import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class ListItem {
  String title;
  int duration;
  bool isRunning;

  ListItem({required this.title, required this.duration, this.isRunning = false});
}


class MyListPage extends StatefulWidget {
  @override
  _MyListPageState createState() => _MyListPageState();
}


class _MyListPageState extends State<MyListPage> {
  List<ListItem> _items = [];
var userId;
  @override
  void initState() {
  userId = FirebaseAuth.instance.currentUser;
_fetchData();
    // TODO: implement initState
    super.initState();
  }
  
  Future<void> _fetchData() async {
    // Fetch data from Firestore and convert it into a list of FirestoreItem objects
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('workers').doc(userId!.uid).collection("tasks").get();
    List<ListItem> items = [];
    querySnapshot.docs.forEach((doc) {
      items.add(ListItem(title: doc['taskName'], duration: doc['time']));
    });

    setState(() {
      _items = items;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My List'),
      ),
      body: 
      
      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('workers').doc(userId!.uid).collection("tasks").where('selected', isEqualTo: true).snapshots(),

        
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
           if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;
            return    ListView.builder(
        itemCount: _items.length > 3 ? 3 : _items.length,
        itemBuilder: (BuildContext context, int index) {
              final status = documents[index]['status'] ?? 'none';
          return ListTile(
                       leading:      
                    ElevatedButton(
              child: Text(_items[index].isRunning ? 'Pause' : 'Play'),
              onPressed: () {
                  setState(() {
                if (_items[index].isRunning) {
                  _items[index].isRunning = false;
                } else {
                  _items[index].isRunning = true;
                  startTimer(index);
                }
              });
              },
            ),
            title: Text(_items[index].title),
            subtitle: Text(status),
            trailing:
              Text('${  _items[index].duration ~/ 3600}:${( _items[index].duration ~/ 60) % 60}:${  _items[index].duration % 60}' , style: TextStyle(
                color: _items[index].isRunning ? Colors.red : Colors.grey,
              ),),
            //  Text(
            //   _items[index].duration.toString(),
            //   style: TextStyle(
            //     color: _items[index].isRunning ? Colors.red : Colors.grey,
            //   ),
            // ),
          onTap: () => _showContextMenu(context, documents[index]),
          );
        },
      );

        }
        
        )

    );
  }
  void _showContextMenu(BuildContext context, DocumentSnapshot document) async {
    final result = await showModalBottomSheet<Priority>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.arrow_upward),
              title: Text('High'),
              onTap: () {
                Navigator.pop(context, Priority.high);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Medium'),
              onTap: () {
                Navigator.pop(context, Priority.medium);
              },
            ),
            ListTile(
              leading: Icon(Icons.arrow_downward),
              title: Text('Low'),
              onTap: () {
                Navigator.pop(context, Priority.low);
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      int time = 0;
      switch (result) {
        case Priority.high:
          time = 4;
          break;
        case Priority.medium:
          time = 3;
          break;
        case Priority.low:
          time = 2;
          break;
      }
      

      await document.reference.update({
        'status': result.toString(),
        'time': time,
      });
      
    }
    
    
  }
  
  void startTimer(int index) {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_items[index].isRunning) {
        timer.cancel();
        return;
      }

      setState(() {
        _items[index].duration--;
      });

      if (_items[index].duration == 0) {
        timer.cancel();
      }
    });
  }
}
enum Priority {
  none,
  high,
  medium,
  low,
}