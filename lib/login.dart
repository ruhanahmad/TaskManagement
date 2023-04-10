import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/controller/getx.dart';
import 'package:taskmanagement/screens/admin_page.dart';

import 'screens/homepage.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   // bool _isWorker = true;
//  UserController userController = Get.put(UserController());
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//    bool _isAdmin = true; // Default to logging in as an admin

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login Page'),
//       ),
//       body:
//             Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               'Login as:',
//               style: TextStyle(fontSize: 20.0),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Radio(
//                   value: true,
//                   groupValue:  _isAdmin,
//                   onChanged: (value) {
//                     setState(() {
//                        _isAdmin = value!;
//                     });
                   
//                   //     builder.isWorker = value!;
//                   //   builder.update();
//                   //  Get.forceAppUpdate();
//                   },
//                 ),
//                        Text('Admin'),
             
//                 SizedBox(width: 20.0),
//                 Radio(
//                   value: false,
//                   groupValue:  _isAdmin,
//                   onChanged: (value) {
//                    onChanged: (value) {
//                     setState(() {
//                       _isAdmin = value;
//                     });
//                   };
//                   //     builder.isWorker = value!;
//                   //       builder.update();
//                   //  Get.forceAppUpdate();
//                       // userController.update();
                 
//                   },
//                 ),
//                  Text('Worker'),
//               ],
//             ),
//             TextFormField(
//               controller: _emailController,
//               decoration: InputDecoration(
//                 labelText: 'Email',
//               ),
//             ),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//               ),
//             ),
//             SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () async {
//                    if (_isAdmin) {
                    
//                   } else {
                  
//                   }
//                 //      builder.userType =await  builder.isWorker ? 'worker' : 'admin';
//                 //      builder.update();
//                 // builder.emailSignupLogin(_emailController.text,_passwordController.text);
//               },
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       )
//       // GetBuilder<UserController>(
//       //   init: UserController(),
//       //   builder: (builder){
//       //  return   
    
//       //   })

//     );
//   }

//   void _signInWithEmailAndPassword(String email,String password) async {
//         userController.userType = userController.isWorker ? 'worker' : 'admin';
//               // userController.update();
//              userController.userType == "worker" ? 
//              userController.emailSignupLogin(  email,password)
            
//               :
//              await userController.checksIFSignUp(_emailController.text,_passwordController.text);

//     // try {
//     //   UserCredential userCredential =
//     //       await _auth.signInWithEmailAndPassword(
//     //     email: _emailController.text,
//     //     password: _passwordController.text,
//     //   );
//     //   User? user = userCredential.user;
      
//     //   if (user != null) {
//     //     String userType = _isWorker ? 'worker' : 'admin';
//     //     // TODO: Implement logic to redirect user to appropriate page based on userType
//     //   userType == "worker" ?   Get.to(()=> HomePage()) :await userController.checksIFSignUp(_emailController.text);

//     //   }
//     // } on FirebaseAuthException catch (e) {
//     //   if (e.code == 'user-not-found') {
//     //     print('No user found for that email.');
//     //   } else if (e.code == 'wrong-password') {
//     //     print('Wrong password provided for that user.');
//     //   }
//     // }
//   }
// }


import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isAdmin = true; // Default to logging in as an admin
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Login as'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: true,
                  groupValue: _isAdmin,
                  onChanged: (value) {
                    setState(() {
                      _isAdmin = value!;
                    });
                  },
                ),
                Text('Admin'),
                Radio(
                  value: false,
                  groupValue: _isAdmin,
                  onChanged: (value) {
                    setState(() {
                      _isAdmin = value!;
                    });
                  },
                ),
                Text('Worker'),
              ],
            ),
            SizedBox(height: 30),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _loginController,
                decoration: InputDecoration(
                  labelText: 'Login',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async{
                // Validate login and password credentials
                String login = _loginController.text;
                String password = _passwordController.text;
                if (login.isNotEmpty && password.isNotEmpty){
                  if (_isAdmin) {
                await userController.checksIFSignUp(_loginController.text,_passwordController.text);
                  } else {
                  await  userController.adminSignin(_loginController.text,_passwordController.text);
                  Get.to(HomePage());

                    // Log in as worker
                    // Perform worker login logic here
                  }
                }
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
