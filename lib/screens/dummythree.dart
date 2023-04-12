import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FirestoreItem {
  final String title;
   int countdownDuration;

  FirestoreItem({required this.title, required this.countdownDuration});
}



class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<FirestoreItem> _items = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Fetch data from Firestore and convert it into a list of FirestoreItem objects
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('myCollection').get();
    List<FirestoreItem> items = [];
    querySnapshot.docs.forEach((doc) {
      items.add(FirestoreItem(title: doc['title'], countdownDuration: doc['countdownDuration']));
    });

    setState(() {
      _items = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          FirestoreItem item = _items[index];
    
          return ListTile(
            title: Text(item.title),
            subtitle: Text('Countdown: ${item.countdownDuration}'),
            trailing: ElevatedButton(
              onPressed: () {
                // Start countdown timer for this item
                Timer(Duration(seconds: 1), () {
                  setState(() {
                    item.countdownDuration--;
                  });
                });
              },
              child: Text('Press'),
            ),
          );
        },
      ),
    );
  }
}
