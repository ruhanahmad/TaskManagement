import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/controller/getx.dart';
import 'package:taskmanagement/login.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  // final _firstNameController = TextEditingController();
  // final _lastNameController = TextEditingController();
  // final _jobTitleController = TextEditingController();
  // final _emailController = TextEditingController();
  // final _phoneController = TextEditingController();

  @override
  // void dispose() {
  //   _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   _jobTitleController.dispose();
  //   _emailController.dispose();
  //   _phoneController.dispose();
  //   super.dispose();
  // }

  UserController userController  = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel"),
      actions: [
        ElevatedButton(onPressed: ()async{
         await FirebaseAuth.instance.signOut();
  Get.to(LoginScreen());

      }, child: Text("Logout"))
      ],
      ),
    
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: userController.firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
                // ElevatedButton(onPressed: ()async{
              //    await FirebaseAuth.instance.signOut();
              // Get.to(LoginPage());
              
              // }, child: Text("Logout")),
              TextFormField(
                controller: userController.lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: userController.jobTitleController,
                decoration: InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: userController.emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email address';
                  }
                  if (!isValidEmail(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
                          TextFormField(
                controller: userController.passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  // if (!isValidEmail(value)) {
                  //   return 'Please enter a valid email address';
                  // }
                  return null;
                },
              ),
              TextFormField(
                controller: userController.phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    userController.emailSignupWorker();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    return RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email);
  }

 
}
