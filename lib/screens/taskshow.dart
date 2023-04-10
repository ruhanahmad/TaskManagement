//---------------------------------------------------------------//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/controller/getx.dart';

class MyListView extends StatefulWidget {
  @override
  State<MyListView> createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Example'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('workers').doc(userController.userId!.uid).collection("tasks").snapshots(),
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

              return ListTile(
                title: Text(document['taskName']),
                subtitle: Text('Priority $status, Time: $time hours'),
                onTap: () => _showContextMenu(context, document),
              );
            },
          );
        },
      ),
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
}

enum Priority {
  none,
  high,
  medium,
  low,
}



// import 'package:flutter/material.dart';

// class Task {
//   final String title;
//   int clicks;
//   Priority priority;

//   Task({required this.title, this.clicks = 0, this.priority = Priority.none});
// }

// enum Priority { none, low, medium, high }

// class TaskListScreen extends StatefulWidget {
//   @override
//   _TaskListScreenState createState() => _TaskListScreenState();
// }

// class _TaskListScreenState extends State<TaskListScreen> {
//   final List<Task> _tasks = [
//     Task(title: 'Task 1'),
//     Task(title: 'Task 2'),
//     Task(title: 'Task 3'),
//     Task(title: 'Task 4'),
//     Task(title: 'Task 5'),
//   ];

//   int _clickCount = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task List'),
//       ),
//       body: ListView.builder(
//         itemCount: _tasks.length,
//         itemBuilder: (BuildContext context, int index) {
//           final task = _tasks[index];
//           return ListTile(
//             title: Text(task.title),
//             subtitle: Text('Clicks: ${task.clicks}'),
//             onTap: () {
//               if (_clickCount < 3) {
//                 setState(() {
//                   _clickCount++;
//                   task.clicks++;
//                 });
//               }
//             },
//             onLongPress: () {
//               _showPriorityMenu(context, task);
//             },
//           );
//         },
//       ),
//     );
//   }

//   void _showPriorityMenu(BuildContext context, Task task) async {
//     final result = await showModalBottomSheet<Priority>(
//       context: context,
//       builder: (BuildContext context) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               title: Text('High'),
//               onTap: () {


//                 Navigator.pop(context, Priority.high);
//               },
//             ),
//             ListTile(
//               title: Text('Medium'),
//               onTap: () {
//                 Navigator.pop(context, Priority.medium);
//               },
//             ),
//             ListTile(
//               title: Text('Low'),
//               onTap: () {
//                 Navigator.pop(context, Priority.low);
//               },
//             ),
//           ],
//         );
//       },
//     );

//     if (result != null) {
//       setState(() {
//         task.priority = result;
//       });
//     }
//   }
// }


//--------------------------------------------------------//

// import 'package:flutter/material.dart';

// class CounterExample extends StatefulWidget {
//   const CounterExample({Key? key}) : super(key: key);

//   @override
//   _CounterExampleState createState() => _CounterExampleState();
// }

// class _CounterExampleState extends State<CounterExample> {
//   int _maxTaps = 3;

//   final Map<String, int> _counters = {
//     'List Tile 1': 0,
//     'List Tile 2': 0,
//     'List Tile 3': 0,
//   };

//   void _incrementCounter(String key) {
//     if (_counters[key]! < _maxTaps) {
//       setState(() {
//         _counters[key] = _counters[key]! + 1;
//       });
//     }
//   }

//   void _resetCounter(String key) {
//     setState(() {
//       _counters[key] = 0;
//     });
//   }

//   void _showPriorityDialog(String key) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: Text('Set Priority'),
//           children: [
//             SimpleDialogOption(
//               onPressed: () {
//                 // TODO: set priority to high
//                 Navigator.pop(context);
//               },
//               child: Text('High'),
//             ),
//             SimpleDialogOption(
//               onPressed: () {
//                 // TODO: set priority to medium
//                 Navigator.pop(context);
//               },
//               child: Text('Medium'),
//             ),
//             SimpleDialogOption(
//               onPressed: () {
//                 // TODO: set priority to low
//                 Navigator.pop(context);
//               },
//               child: Text('Low'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Counter Example'),
//       ),
//       body: ListView.builder(
//         itemCount: _counters.length,
//         itemBuilder: (BuildContext context, int index) {
//           final key = _counters.keys.elementAt(index);
//           final counter = _counters[key]!;

//           return ListTile(
//             title: Text(key),
//             subtitle: Text('Taps: $counter'),
//             onTap: () {
//               _incrementCounter(key);
//             },
//             onLongPress: () {
//               _showPriorityDialog(key);
//             },
//             trailing: counter > 0
//                 ? IconButton(
//                     icon: Icon(Icons.refresh),
//                     onPressed: () {
//                       _resetCounter(key);
//                     },
//                   )
//                 : null,
//           );
//         },
//       ),
//     );
//   }
// }
