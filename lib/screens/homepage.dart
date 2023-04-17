import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/controller/getx.dart';
import 'package:taskmanagement/screens/addTaskThree.dart';
import 'package:taskmanagement/screens/addTaskTwo.dart';
import 'package:taskmanagement/screens/dummy.dart';
import 'package:taskmanagement/screens/dummyfour.dart';
import 'package:taskmanagement/screens/dummythree.dart';
import 'package:taskmanagement/screens/dumyytwo.dart';
import 'package:taskmanagement/screens/task.dart';
import 'package:taskmanagement/screens/taskshow.dart';

import '../login.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

UserController userController = Get.put(UserController());
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return 
    
        DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      automaticallyImplyLeading: false,
            actions: [
        ElevatedButton(onPressed: ()async{
         await FirebaseAuth.instance.signOut();
  Get.to(LoginScreen());

      }, child: Text("Logout")),
              ElevatedButton(onPressed: ()async{
                Get.to(AddNewTaskThree());
  //        await FirebaseAuth.instance.signOut();
  // Get.to(LoginScreen());

      }, child: Text("Add Task")),

              ElevatedButton(onPressed: ()async{
// Get.to(TaskListScreen());
await userController.getIDo();
Get.to(MyListView());
// Get.to(MyListScreen());


      }, child: Text("tasklistss")),
              ElevatedButton(onPressed: ()async{
// Get.to(TaskListScreen());
// await userController.getIDo();
// Get.to(MyListView());
// Get.to(MyListScreen());

 Get.to(MyListPage());


      }, child: Text("selectonpage")),
      ],
  //           actions: [
  //       ElevatedButton(onPressed: ()async{
  //        await FirebaseAuth.instance.signOut();
  // Get.to(LoginScreen());

  //     }, child: Text("Logout"))
  //     ],
      bottom: TabBar(
        tabs: [
          Tab(text: "All Tasks",),
          Tab(text: "Listed Tasks",),
          Tab(icon: Icon(Icons.directions_car)),
        ],
      ),
      title: Text('Worker Panel'),
    ),
    body: TabBarView(
      children: [
    MyListScreen(),
    MyListPage(),
          MyListView(),
        // Icon(Icons.directions_transit, size: 350),
      
      ],
    ),
  ),
);
    
//     Scaffold(
      
//             appBar: AppBar(title: Text("Worker panel"),
//            automaticallyImplyLeading: false,
//       actions: [
//         ElevatedButton(onPressed: ()async{
//          await FirebaseAuth.instance.signOut();
//   Get.to(LoginScreen());

//       }, child: Text("Logout")),
//               ElevatedButton(onPressed: ()async{
//                 Get.to(TasksPage());
//   //        await FirebaseAuth.instance.signOut();
//   // Get.to(LoginScreen());

//       }, child: Text("Add Task")),

//               ElevatedButton(onPressed: ()async{
// // Get.to(TaskListScreen());
// await userController.getIDo();
// Get.to(MyListView());
// // Get.to(MyListScreen());


//       }, child: Text("tasklistss")),
//               ElevatedButton(onPressed: ()async{
// // Get.to(TaskListScreen());
// // await userController.getIDo();
// // Get.to(MyListView());
// Get.to(MyListScreen());


//       }, child: Text("selectonpage")),
//       ],
//       ),
//       body: Container(child: Column(children: [
//         Text("data")
//       ]
// 
// ,),),
//     );
  }
}