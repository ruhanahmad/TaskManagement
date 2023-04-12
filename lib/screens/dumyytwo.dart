// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CountdownTile extends StatefulWidget {
//   const CountdownTile({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _CountdownTileState createState() => _CountdownTileState();
// }

// class _CountdownTileState extends State<CountdownTile> {
//   late SharedPreferences _prefs;
//   late int _countdownValue = 0;
//   bool _isPlaying = false;
//   late Timer _timer;

//   @override
//   void initState() {
//     super.initState();
//     _loadCountdownValue();
//   }

//   void _loadCountdownValue() async {
//     _prefs = await SharedPreferences.getInstance();
//     _countdownValue = _prefs.getInt("widget.title") ?? 4 * 60 * 60; // Default value is 4 hours
//   }

//   void _saveCountdownValue() {
//     _prefs.setInt(widget.title, _countdownValue);
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_countdownValue > 0) {
//           _countdownValue--;
//           _saveCountdownValue();
//         } else {
//           _isPlaying = false;
//           _timer.cancel();
//            _saveCountdownValue();
//         }
//       });
//     });
//   }

//   void _pauseTimer() {
//     _timer.cancel();
//   }

//   void _toggleTimer() {
//     if (_isPlaying) {
//       _isPlaying = false;
//       _pauseTimer();
//     } else {
//       _isPlaying = true;
//       _startTimer();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListTile(
//         leading: IconButton(
//           icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
//           onPressed: _toggleTimer,
//         ),
//         title: Text(widget.title),
//         trailing: Text('${_countdownValue ~/ 3600}:${(_countdownValue ~/ 60) % 60}:${_countdownValue % 60}'),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _pauseTimer();
//     super.dispose();
//   }
// }

// class CountdownList extends StatelessWidget {
//   const CountdownList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         itemCount: 5, // Replace with the number of countdowns you want to display
//         itemBuilder: (context, index) {
//           return CountdownTile(title: 'Countdown ${index + 1}');
//         },
//       ),
//     );
//   }
// }
//-------------------------------------------------------------------------------------//
// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// class Task {
//   String name;
//   int duration;

//   Task({ required this.name, required this.duration});

//   factory Task.fromJson(Map<String, dynamic> json) {
//     return Task(
//       name: json['name'],
//       duration: json['duration'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'duration': duration,
//     };
//   }
// }

// class TaskManager extends StatefulWidget {
//   @override
//   _TaskManagerState createState() => _TaskManagerState();
// }

// class _TaskManagerState extends State<TaskManager> {
   

//   List<Task> _tasks = [
//  Task(name: "name", duration: 4),
//   Task(name: "name", duration: 4),
//    Task(name: "name", duration: 4),
//     Task(name: "name", duration: 4),

//   ];

//   int _selectedTaskIndex = -1;
//   Timer? _timer ;
//   int _elapsedSeconds = 0;

//   @override
//   void initState() {
//     super.initState();
   
//     _loadTasks();
   
//   }

//   void _loadTasks() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> taskList = prefs.getStringList('tasks') ?? [];
//     setState(() {
//       _tasks = taskList.map((taskJson) => Task.fromJson(taskJson as Map<String, dynamic>)).toList() ;
//     });
//   }

//   void _saveTasks() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> taskList = _tasks.map((task) => task.toJson()).toList() as List<String>;
//     prefs.setStringList('tasks', taskList);
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _elapsedSeconds++;
//       });
//     });
//   }

//   void _stopTimer() {
//     _timer!.cancel();
//     _elapsedSeconds = 0;
//   }

//   void _selectTask(int index) {
//     if (_selectedTaskIndex == index) {
//       _stopTimer();
//       setState(() {
//         _selectedTaskIndex = -1;
//       });
//     } else {
//       if (_timer != null) {
//         _stopTimer();
//       }
//       setState(() {
//         _selectedTaskIndex = index;
//         _elapsedSeconds = _tasks[index].duration;
//       });
//     }
//   }

//   void _toggleTimer() {
//     if (_timer == null) {
//       _startTimer();
//     } else {
//       _stopTimer();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Task Manager'),
//       ),
//       body: ListView.builder(
//         itemCount: _tasks.length,
//         itemBuilder: (BuildContext context, int index) {
//           return ListTile(
//             title: Text(_tasks[index].name),
//             subtitle: Text('${_tasks[index].duration} seconds'),
//             trailing: _selectedTaskIndex == index
//                 ? IconButton(
//                     icon: Icon(_timer == null ? Icons.play_arrow : Icons.pause),
//                     onPressed: _toggleTimer,
//                   )
//                 : null,
//             onTap: () => _selectTask(index),
//             selected: _selectedTaskIndex == index,
//           );}));}}





import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownPage extends StatefulWidget {
  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
 late Timer _timer;
  int _countdownValue = 120;
  bool _isCountdownRunning = false;

  @override
  void initState() {
    super.initState();
    _loadCountdownValue();
 _timer = Timer.periodic(Duration(seconds: 1), (timer) {

 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Countdown')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${_countdownValue ~/ 3600}:${(_countdownValue ~/ 60) % 60}:${_countdownValue % 60}'),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text(_isCountdownRunning ? 'Pause' : 'Play'),
              onPressed: () {
                setState(() {
                  if (_isCountdownRunning) {
                    _pauseCountdown();
                  } else {
                    _startCountdown();
                  }
                  _isCountdownRunning = !_isCountdownRunning;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                   _countdownValue = 120;
                });
                
              },
              child: Container(
                child: Text("CountdownVakue"),
                
                ))
          ],
        ),
      ),
    );
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _countdownValue--;
      });
    });
  }

  void _pauseCountdown() {
    _timer.cancel();
  }

  void _loadCountdownValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _countdownValue = prefs.getInt('countdown_value') ?? 0;
    });
  }

  void _saveCountdownValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('countdown_value', _countdownValue);
  }

  @override
  void dispose() {
    _pauseCountdown();
    _saveCountdownValue();
    super.dispose();
  }
}


// class CountdownTimer extends StatefulWidget {
//   @override
//   _CountdownTimerState createState() => _CountdownTimerState();
// }

// class _CountdownTimerState extends State<CountdownTimer> {
//   Timer? _timer;
//   int _remainingSeconds = 60;
//   bool _isCountingDown = false;

//   void _startCountdown() {
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         if (_remainingSeconds > 0) {
//           _remainingSeconds--;
//         } else {
//           _timer!.cancel();
//         }
//       });
//     });
//   }

//   void _pauseCountdown() {
//     _timer!.cancel();
//   }

//   void _toggleCountdown() {
//     setState(() {
//       _isCountingDown = !_isCountingDown;
//       if (_isCountingDown) {
//         _startCountdown();
//       } else {
//         _pauseCountdown();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Countdown Timer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               '$_remainingSeconds',
//               style: TextStyle(fontSize: 64),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _toggleCountdown,
//               child: Text(_isCountingDown ? 'Pause' : 'Play'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }
