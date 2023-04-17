// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_countdown_timer/current_remaining_time.dart';
// import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

// class MyWidgetss extends StatefulWidget {
//   @override
//   _MyWidgetssState createState() => _MyWidgetssState();
// }

// class _MyWidgetssState extends State<MyWidgetss> {
//   Stream<QuerySnapshot>? _stream;
// var userId;
// StreamController<DocumentSnapshot> _streamController = StreamController<DocumentSnapshot>();

//  @override
// void initState() {
//   super.initState();
//   FirebaseFirestore.instance.collection('workers').doc(userId!.uid).collection("tasks").snapshots()
//     .listen((documentSnapshot) {
//       _streamController.add(documentSnapshot as DocumentSnapshot<Object?>);
//     });
// }


//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: _stream,
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) {
//           return Center(child: CircularProgressIndicator());
//         }

//         List<QueryDocumentSnapshot>? documents = snapshot.data!.docs;

//         return Scaffold(
//           body: ListView.builder(
//             itemCount: documents.length,
//             itemBuilder: (context, index) {
//               Map<String, dynamic> data = documents[index].data() as Map<String, dynamic>;
//               String title = data['taskName'];
//               int duration = data['time'];
        
//           return ListTile(
//               title: Text(title),
//               subtitle: 
//            CountdownTimer(duration),
//             );
//             },
//           ),
//         );
//       },
//     );
//   }
// }


// class CountdownTimer extends StatefulWidget {
//   final int duration;

//   const CountdownTimer(this.duration);

//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }

// class _CountdownTimerState extends State<CountdownTimer> with TickerProviderStateMixin {
//   late final Ticker _ticker;
//   late int _remainingTime;

//   @override
//   void initState() {
//     super.initState();
//     _remainingTime = widget.duration;
//     _ticker = createTicker(_onTick)..start();
//   }

//   @override
//   void dispose() {
//     _ticker.dispose();
//     super.dispose();
//   }

//   void _onTick(Duration elapsed) {
//     setState(() {
//       _remainingTime = widget.duration - elapsed.inSeconds;
//     });
//   }

//   void _onButtonPressed() {
//     if (_ticker.isTicking) {
//       _ticker.stop();
//     } else {
//       _ticker.start();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text('Remaining time: $_remainingTime seconds'),
//         ElevatedButton(
//           onPressed: _onButtonPressed,
//           child: Text(_ticker.isTicking ? 'Pause' : 'Start'),
//         ),
//       ],
//     );
//   }
// }

