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
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_items[index].title),
            trailing: Text(
              _items[index].duration.toString(),
              style: TextStyle(
                color: _items[index].isRunning ? Colors.red : Colors.grey,
              ),
            ),
            onTap: () {
              setState(() {
                if (_items[index].isRunning) {
                  _items[index].isRunning = false;
                } else {
                  _items[index].isRunning = true;
                  startTimer(index);
                }
              });
            },
          );
        },
      ),
    );
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
