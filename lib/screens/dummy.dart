import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/controller/getx.dart';

class MyListScreen extends StatefulWidget {
  @override
  _MyListScreenState createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
   final FirebaseFirestore firestore = FirebaseFirestore.instance;

UserController userController = Get.put(UserController());
var userId;
@override
  void initState() {
   
  userId = FirebaseAuth.instance.currentUser;

 print(userId);

    // TODO: implement initState
    super.initState();
  }
  List<String> _selectedTiles = [];
  bool _isSelected(String title) => _selectedTiles.contains(title);

  final List<String> _titles = [
    'Tile 1',
    'Tile 2',
    'Tile 3',
    'Tile 4',
    'Tile 5',
    'Tile 6',
    'Tile 7',
    'Tile 8',
    'Tile 9',
    'Tile 10',
  ];

  void _toggleTile(String title) {
    setState(() {
      if (_isSelected(title)) {
        _selectedTiles.remove(title);
      } else if (_selectedTiles.length < 3) {
        _selectedTiles.add(title);
      }
    });
  }

  Future<void> updateFieldInMultipleDocs() async {
  final CollectionReference usersRef = FirebaseFirestore.instance.collection('workers').doc(userId!.uid).collection("tasks");
  
  // Get a list of documents to update
  QuerySnapshot querySnapshot = await usersRef.where('taskName', whereIn: _selectedTiles).get();
  
  // Loop through the documents and update the field
  querySnapshot.docs.forEach((doc) async {
    await doc.reference.update({'selected': true});
  });
}


  Future<void> _updateSelections() async {
    // Update Firestore with selected tiles
    CollectionReference selections =
        FirebaseFirestore.instance.collection('workers').doc(userId!.uid).collection('tasks');

    await selections.doc(userId!.uid).set({'selected_tiles': _selectedTiles});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Select up to 3 tiles'),
      // ),
      body:    StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('workers').doc(userId!.uid).collection("tasks").where("taskComplete", isEqualTo: false).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              final document = documents[index];
              final status = document['status'] ?? 'none';
              final time = document['time'] ?? 0;

              return
               ListTile(
                title: GestureDetector(
                  onTap: () => _toggleTile(document['taskName']?? "none"),
                  child: Text(document['taskName'])),
                subtitle: GestureDetector(
                  onTap: () => _showContextMenu(context, documents[index]),
                  child: Text('Priority $status')),
              
                tileColor: _isSelected(document['taskName']?? "none") ? Colors.blue : null,
              );
            },
          );
        },
      ),
      
      // ListView.builder(
      //   itemCount: _titles.length,
      //   itemBuilder: (context, index) {
      //     final title = _titles[index];

      //     return ListTile(
      //       title: Text(title),
      //       onTap: () => _toggleTile(title),
      //       tileColor: _isSelected(title) ? Colors.blue : null,
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectedTiles.length == 3 ? updateFieldInMultipleDocs : null,
        child: Icon(Icons.check),
        backgroundColor:
            _selectedTiles.length == 3 ? Colors.green : Colors.grey,
      ),
    );
  }
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


void intTo(){}
enum Priority {
  none,
  high,
  medium,
  low,
}
