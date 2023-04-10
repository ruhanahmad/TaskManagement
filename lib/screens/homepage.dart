import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../login.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
            appBar: AppBar(title: Text("Worker panel"),
           automaticallyImplyLeading: false,
      actions: [
        ElevatedButton(onPressed: ()async{
         await FirebaseAuth.instance.signOut();
  Get.to(LoginScreen());

      }, child: Text("Logout"))
      ],
      ),
      body: Container(child: Column(children: [
        Text("data")
      ],),),
    );
  }
}