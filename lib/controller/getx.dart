import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/screens/admin_page.dart';
import 'package:taskmanagement/screens/homepage.dart';



class UserController extends GetxController {
 String? userType;
      // String have   =  "admin";
  final FirebaseAuth _auth = FirebaseAuth.instance;
    User? userId ;
 bool isWorker = true;
 getIDo()async{
  userId = await FirebaseAuth.instance.currentUser;
  update();
 print(userId);
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