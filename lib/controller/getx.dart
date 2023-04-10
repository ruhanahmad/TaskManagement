import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/models/worker.dart';
import 'package:taskmanagement/screens/admin_page.dart';
import 'package:taskmanagement/screens/homepage.dart';



class UserController extends GetxController {
 String? userType;
      // String have   =  "admin";
  final FirebaseAuth _auth = FirebaseAuth.instance;
    User? userId ;
 bool isWorker = true;
List accountsList = [];



    dynamic valuess;
      List<DocumentSnapshot> vis = [];
       var idAccount;
String? descriptionController; 
String? titleController;

Future  getIDo()async{
  userId = await FirebaseAuth.instance.currentUser;
  update();
 print(userId);
}
       addTasks(String? id) async {
         final firebaseInstance = FirebaseFirestore.instance;
    final docRef = firebaseInstance.collection('workers').doc(id).collection("tasks");

    final data = {
      'taskName': titleController,
      'taskDescription': descriptionController,
       'status':"inactive",
        'time':'0',
    };

    await docRef.add(data);

    Get.snackbar("Data Added", "Data added successfully");
       }
 Future  getAccountData() async {
   await getIDo();
  // EasyLoading.show();
    // welcome = Welcome();
    // accountss  = Account();
       await FirebaseFirestore.instance
        .collection("workers")
        .get()
        .then((QuerySnapshot value) {
                   vis = value.docs;
       idAccount = vis.first.id;
                //  print(valuess);
                //   // balances  =  valuess['accountB'];
                // //  accountsList.add(Account.fromJson(value));
                //  print(valuess);
             update(); 
        });  
        // EasyLoading.dismiss();
  }

 TextEditingController  firstNameController = TextEditingController();
 TextEditingController  lastNameController = TextEditingController();
 TextEditingController  jobTitleController = TextEditingController();
 TextEditingController  emailController = TextEditingController();
 TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

// saveEditedThing() async {
//  await getIDo();
//  await FirebaseFirestore.instance.collection('account').doc(userId!.uid).update({
//                               'username': textEditingForChange.text,
//                             });


// }

 emailSignupWorker( )async {

     try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      userId = userCredential.user;
      update();
    await  saveData();
   
    }  catch (e) {
    
     Get.snackbar("Error", "Not able to sign up or user already exsist");
       
      }
        
        
     
   
 }
clearss()async{
firstNameController.clear();
lastNameController.clear();
jobTitleController.clear();
emailController.clear();
phoneController.clear();
}
  Future saveData() async {
    final firebaseInstance = FirebaseFirestore.instance;
    final docRef = firebaseInstance.collection('workers').doc(userId!.uid);

    final data = {
      'firstName': firstNameController.text,
      'lastName': lastNameController.text,
      'jobTitle': jobTitleController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    };

    await docRef.set(data);
   await  clearss();
    Get.snackbar("Data Added", "Data added successfully");

   
  }


   emailSignupLogin( String email,String password)async{
      // have = "worker";
     

     try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
     isWorker  =="worker" ? Get.to(()=>HomePage()):Get.to(()=>AdminPage());
      // if (user != null) {
      //   String userType = _isWorker ? 'worker' : 'admin';
      //   // TODO: Implement logic to redirect user to appropriate page based on userType
      // userType == "worker" ?   Get.to(()=> HomePage()) :await checksIFSignUp(email);

      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }



   }


   Future   adminSignin(String email,String password)async{
        try {
      UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );


    //   User? user = userCredential.user;
    //  isWorker  =="worker" ? Get.to(()=>HomePage()):Get.to(()=>AdminPage());
      // if (user != null) {
      //   String userType = _isWorker ? 'worker' : 'admin';
      //   // TODO: Implement logic to redirect user to appropriate page based on userType
      // userType == "worker" ?   Get.to(()=> HomePage()) :await checksIFSignUp(email);

      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }

  }






  Future  checksIFSignUp(String email,String password) async {
    // have   =  "admin";
    update();
    await FirebaseFirestore.instance
        .collection("admin")
        .where('email', isEqualTo:email)
        .get()
        .then((QuerySnapshot querySnapshot) async{
      if (querySnapshot.size > 0) {
    //  emailSignupLogin(email,password);
 await  adminSignin( email, password);
        Get.to(()=>AdminPage());
      } else {
        Get.snackbar("Not Successfull", "You are not admin");
        // Data does not exist
      }
    });
  }
  




}