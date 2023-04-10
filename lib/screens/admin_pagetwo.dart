import 'package:flutter/material.dart';





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanagement/constants.dart';
import 'package:taskmanagement/controller/getx.dart';


class ProfilePage extends StatefulWidget {


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
// @override
  @override
 final _formKey = GlobalKey<FormState>();
  final     _formKeyTwo = GlobalKey<FormState>();
 bool _isEditable = false;
  bool _isEditableTwo =  false;

UserController userController  = Get.put(UserController());
 Future<void>? alerts(){
    showDialog(context: context, builder: (context){
      return     AlertDialog(
        content: new
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.camera),
                SizedBox(width: 5),
                Text('Change passcode '),
              ],
            ),
            SizedBox(height: 30,),
            TextFormField(
                    
                    onChanged: (value) {
            //  userController.reset = value;
                    },
                    decoration: InputDecoration(
               contentPadding:
                   const EdgeInsets.fromLTRB(15.0, 0.0, 10.0, 0.0),
               filled: true,
               fillColor: kPrimaryColor.withOpacity(0.3),
               labelText: 'Enter code you want to reset',
               labelStyle: kFormTextStyle,
               border: InputBorder.none,
               enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15.0),
                 borderSide: const BorderSide(color: Colors.white),
               ),
               focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(15.0),
                 borderSide: const BorderSide(color: kPrimaryColor),
               )),
                    keyboardType: TextInputType.number,
                    obscureText: false,
                    validator: (String? value) {
             if (value!.length < 6 || value.length > 6) {
               return 'Please Enter only  digits';
             }
             return null;
                    },
                  ),

                  GestureDetector(
                    onTap:   () async{

                      
                  // await userController.resetPasscode(userController.reset!);
                    },
                    child: Container(
                      height: 30,
                      width: 50,
                      decoration: BoxDecoration(color: Colors.blue,),
                      child: Text("Submit"),),
                  )
          ],
        ),
      );
    });
  }




  
  Widget build(BuildContext context) {
     String? _dropDownValue;
     final userController = Get.put(UserController());
    return 
   Scaffold(
      backgroundColor: const Color(0xFFf3f4f6),
      body: SingleChildScrollView(
        child:
        
        GetBuilder<UserController>(
          init:UserController(),
          
          builder:(_){
          return        
          Container(
 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // action bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(color: Color(0xFF27282a)),

                ],
              ),

              // Main Heading
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 20),
              //   child: TopHeading(
              //     heading: "Profile Page",
              //   ),
              // ),
              // For buttons
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//                 child: Container(
//                   height: 50,
//                   width: 300,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//             itemCount: userController.contactListThings!.length,
//               itemBuilder: (context, i){
                  
//                     return 
//  Container(
//  margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
//  child: ElevatedButton(
//    onPressed: () {
                    
//            print(userController.contactListThings![i]["name"]);
// var name =userController.contactListThings![i]["name"];
// var email = userController.contactListThings![i]["Email"];
// var iban = userController.contactListThings![i]["iban"];
//            userController.sendMoneyContactName = userController.contactListThings![i]["name"];
//            Get.to(SendMoneyContact(name: name,email:email,iban:iban));
//       //  Navigator.push(context,(MaterialPageRoute(builder: (context){
//       //   return SendMoneyContact(name: userController.contactListThings![i]["name"]);
//       //  })));
//    },
//    child: Text(
//      userController.contactListThings![i]["name"],
//      style: Constant.btnText,
//    ),
//    style: ElevatedButton.styleFrom(
//      onPrimary: const Color(0xFF335ebd),
//      primary: const Color(0xFFe8f1fa),
//      shape: RoundedRectangleBorder(
//        borderRadius: BorderRadius.circular(12),
//      ),
//    ),
//  ),
//     );
              
//               },
//           ),
//                 ),
//               ),




Container(
  
  child: 
  Column(
    children: [
      Container(
        child: Form(
          key: _formKey,
          child: Container(
            width: Get.width/2 +140,
            child: 
            TextFormField(
              // controller: userController.textEditingForChange,
              enabled: _isEditable,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              // decoration: InputDecoration(
              //   hintText: '${userController.usernameFor.toString()}',
              // ),
            ),
          ),
        ),
      ),

SizedBox(height: 20,),
              Row(
                children: [
                  ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      setState(() {
                        _isEditable = true;
                      });
                    },
                  ),
                    ElevatedButton(
                child: Text('Save'),
                onPressed: () async{
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isEditable = false;
                    });

                    // await userController.saveEditedThing();
                    // Save the form data to Firebase
                    // FirebaseFirestore.instance.collection('my_collection').doc('my_document').update({
                    //   'my_field': _textEditingController.text,
                    // });
                  }
                },
              ),
                ],
              ),
    ],
  ),
),
SizedBox(height: 30,),

SizedBox(height: 30,),

Container(
  
  child: 
  Column(
    children: [
      Form(
        key: _formKeyTwo,
        child: Container(
          width: Get.width/2 +140,
          child: TextFormField(
            // controller: userController.textEditingForChangeTwo,
            enabled: _isEditableTwo,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
                    
                if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return "Please enter a valid email address";
            }
            },
            decoration: InputDecoration(
              // hintText: '${userController.emailFor.toString()}',
            ),
          ),
        ),
      ),

              Row(
                children: [
                  ElevatedButton(
                    child: Text('Edit'),
                    onPressed: () {
                      setState(() {
                        _isEditableTwo = true;
                      });
                    },
                  ),
                    ElevatedButton(
                child: Text('Save'),
                onPressed: () async{
                  if (_formKeyTwo.currentState!.validate()) {
                    setState(() {
                      _isEditableTwo = false;
                    });

                    // await userController.saveEditedThingEmail();
                    // Save the form data to Firebase
                    // FirebaseFirestore.instance.collection('my_collection').doc('my_document').update({
                    //   'my_field': _textEditingController.text,
                    // });
                  }
                },
              ),
                ],
              ),
    ],
  ),
),
SizedBox(height: 30,),












// Column(
//   children: [
//         Container(
//           height: 50,
//           width: Get.width,
//           color: Colors.blue,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
         
//           Text(userController.nameFor.toString() + " " + userController.lastNameFor.toString()),
//            GestureDetector(
//             onTap: ()async {
//               await 
//             },
//             child: Text("Edit")),
          
              
            
            
            
//             ],),
//         ),
//         SizedBox(height: 30,),

//                 Container(
//           height: 50,
//           width: Get.width,
//           color: Colors.blue,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
          
//           Text(userController.emailFor.toString()),
//           Text("Edit"),
          
              
            
            
            
//             ],),
//         ),
//           SizedBox(height: 30,),

//                 Container(
//           height: 50,
//           width: Get.width,
//           color: Colors.blue,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
         
//           Text(userController.phoneFor.toString()),
//           // Text("Email"),
          
              
            
            
            
//             ],),
//         ),
//   ],
// ),
              // const Align(
              //   alignment: Alignment.centerLeft,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
              //     child: Text(
              //       "All",
              //       style: TextStyle(
              //         color: Color(0xFFb6b9c0),
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
  
  //                           Container(
  //               padding: const EdgeInsets.all(12.0),
  //               height: 85,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               child: 
  //               DropdownButton(
  //     hint: _dropDownValue == null
  //         ? Text(_.dropDownValue.toString())
  //         : Text(
  //             _dropDownValue,
  //             style: TextStyle(color: Colors.blue),
  //           ),
  //     isExpanded: true,
  //     iconSize: 30.0,
  //     style: TextStyle(color: Colors.blue),
  //     items: ['Premium', 'Topaz'].map(
  //       (val) {
  //         return DropdownMenuItem<String>(
  //           value: val,
  //           child: Text(val),
  //         );
  //       },
  //     ).toList(),
  //     onChanged: (val) {
  //          print(val);
     
  //           _.dropDownValue = val.toString();
  //           _.update();
        
  //     },
  //   ),


 
  //             ),
  //              ElevatedButton.icon(
  //                       onPressed: () async{
  //                       await  _.updatePackage();
  //                         // showModalBottomSheet(
  //                         //     shape: RoundedRectangleBorder(
  //                         //       borderRadius: BorderRadius.circular(12.0),
  //                         //     ),
  //                         //     context: context,
  //                         //     builder: (context) => sheet());
  //                       },
  //                       icon: const Icon(Icons.add),
  //                       label: const Text("Change Package"),
  //                       style: ElevatedButton.styleFrom(
  //                         onPrimary: const Color(0xFFffffff),
  //                         primary: const Color(0xFF095fd8),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                       ),
  //                     ),

  //  SizedBox(height: 12,),

  //                          Container(
  //               padding: const EdgeInsets.all(12.0),
  //               height: 85,
  //               decoration: BoxDecoration(
  //                 color: Colors.white,
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               child: 
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //               Text("Change Passcode"),
  //              ElevatedButton.icon(
  //                       onPressed: () async{

  //                         await alerts();
  //                       // await  _.updatePackage();
  //                       // Get.to(ExampleHomePage());
                        
  //                         // showModalBottomSheet(
  //                         //     shape: RoundedRectangleBorder(
  //                         //       borderRadius: BorderRadius.circular(12.0),
  //                         //     ),
  //                         //     context: context,
  //                         //     builder: (context) => sheet());
  //                       },
  //                       icon: const Icon(Icons.add),
  //                       label: const Text("Change Passcode"),
  //                       style: ElevatedButton.styleFrom(
  //                         onPrimary: const Color(0xFFffffff),
  //                         primary: const Color(0xFF095fd8),
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(20),
  //                         ),
  //                       ),
  //                     ),


                      

  //               ],)
    //             DropdownButton(
    //   hint: _dropDownValue == null
    //       ? Text(_.dropDownValue.toString())
    //       : Text(
    //           _dropDownValue,
    //           style: TextStyle(color: Colors.blue),
    //         ),
    //   isExpanded: true,
    //   iconSize: 30.0,
    //   style: TextStyle(color: Colors.blue),
    //   items: ['Premium', 'Topaz'].map(
    //     (val) {
    //       return DropdownMenuItem<String>(
    //         value: val,
    //         child: Text(val),
    //       );
    //     },
    //   ).toList(),
    //   onChanged: (val) {
    //        print(val);
     
    //         _.dropDownValue = val.toString();
    //         _.update();
        
    //   },
    // ),


 
              // ),

  // SizedBox(height: 30,),

  //               Container(
  //         height: 50,
  //         width: Get.width,
  //         color: Colors.blue,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //         Text("Limit"),
  //         Text(userController.limitFor.toString()),
          
              
            
            
            
  //           ],),
  //       ),
  // SizedBox(height: 30,),
  // GestureDetector(
  //   onTap: () async{
  //     await userController.logOut();
  //   },
  //   child: Container(
  //     color: Colors.blueAccent,
  //     height: 30,
  //     width: 50,
  //     child: Text("Logout"),),
  // )
            ],
          ),
        );
        })
        
  
      ),
    );
   
  }
}



// For modal bottom sheet display screen
Widget sheet() => Column(children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: const Color(0xFFd9d7d7),
          ),
          height: 5,
          width: 50,
        ),
      ),
      const ListSheet(
        title: "Create Payment Method",
        subtitle: "Send money to anyone with a link",
        icons: Icon(
          Icons.link,
          color: Color(0xFF096df9),
          size: 18,
        ),
      ),
      const ListSheet(
        title: "Add a bank recipient",
        subtitle: "Transfer money to nay bank account",
        icons: Icon(
          Icons.account_balance,
          color: Color(0xFF096df9),
          size: 18,
        ),
      ),
      const ListSheet(
        title: "Invite a friend",
        subtitle: "Share a link to join Revolut",
        icons: Icon(
          Icons.favorite,
          color: Color(0xFF096df9),
          size: 18,
        ),
      ),
      const ListSheet(
        title: "Add a contact",
        subtitle: "Add a contact using phone or emial",
        icons: Icon(
          Icons.person,
          color: Color(0xFF096df9),
          size: 18,
        ),
      ),
    ]);

// for modal bottom sheet listTile
class ListSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icons;
  const ListSheet(
      {Key? key,
      required this.icons,
      required this.subtitle,
      required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFe4f0fe),
          child: icons,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF096df9),
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
              color: Color(0xFFb7b8ba),
              fontWeight: FontWeight.w500,
              fontSize: 15),
        ),
      ),
    );
  }
}
