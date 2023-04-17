import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanagement/screens/addTaskTwo.dart';
import 'package:taskmanagement/screens/addnewtask.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/screens/completedTask.dart';
class WorkerList extends StatefulWidget {
  @override
  State<WorkerList> createState() => _WorkerListState();
}

class _WorkerListState extends State<WorkerList> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Firestore Example'),
      // ),
      body: 
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('workers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (!snapshot.hasData) {
            return Text('Loading...');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final document = snapshot.data!.docs[index];
              final id = snapshot.data!.docs[index].id;
              final data = document.data() as Map<String, dynamic>;
              final firstName = data['firstName'] ?? '';
              final lastName = data['lastName'] ?? '';
              final jobTitle = data['jobTitle'] ?? '';

              return ListTile(
                title: Text('$firstName $lastName'),
                subtitle: Text(jobTitle),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                   Get.to(AddNewTaskTwo(id:id));
                  
                  },
                ),
                onTap: () {
                  Get.to( CompletedList(id:id));
                },
              );
            },
          );
        },
      ),
    );
  }
}
