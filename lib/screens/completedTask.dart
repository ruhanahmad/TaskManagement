import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskmanagement/screens/addTaskTwo.dart';
import 'package:taskmanagement/screens/addnewtask.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class CompletedList extends StatefulWidget {
CompletedList({this.id});
  String? id;
  
  @override
  State<CompletedList> createState() => _CompletedListState();
}

class _CompletedListState extends State<CompletedList> {
  double _rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Firestore Example'),
      // ),
      body: 
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('workers').doc(widget.id!).collection("tasks").where("taskComplete",isEqualTo: true).snapshots(),
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
              final firstName = data['taskName'] ?? '';
              final lastName = data['taskDescription'] ?? '';
              final jobTitle = data['jobTitle'] ?? '';
              final rating = data["rating"]?? 0;
              final overDue = data ["overdue"] ?? false;

              return ListTile(
                leading: overDue ? Text("overDue",style: TextStyle(color: Colors.red),):Text("onTime"),
                title: Text('$firstName'  + ":Description:" + '$lastName'),
                subtitle:   RatingBar.builder(
          initialRating: double.parse(rating),
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 30,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
        ),
                trailing: 
                ElevatedButton(
          onPressed: ()async {
            // _submitRating();
             await 
              document.reference.update({
        'rating': _rating.toString(),
      
        // 'time': time,
      });
    // setState(() {
    //   _rating = 0.0;
    // });

          },
          child: Text('Submit'),
        ),
                
              );
            },
          );
        },
      ),
    );
  }
}
