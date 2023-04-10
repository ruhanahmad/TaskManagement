import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:taskmanagement/controller/getx.dart';

import 'package:taskmanagement/screens/categorycard.dart';

class AddNewTaskTwo extends StatefulWidget {

   AddNewTaskTwo({Key? key,required this.id}) : super(key: key);
  String id;
  @override
  State<AddNewTaskTwo> createState() => _AddNewTaskTwoState();
}

class _AddNewTaskTwoState extends State<AddNewTaskTwo> {
  TextEditingController titlecontroller = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
  late TextEditingController _Datecontroller;
  late TextEditingController _StartTime;
  late TextEditingController _EndTime;
  DateTime SelectedDate = DateTime.now();
  String Category = "Meeting";
   UserController userController = Get.put(UserController());

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        _Datecontroller.text =
            '${DateFormat('EEE, MMM d, ' 'yy').format(selected)}';
      });
    }
  }

  _selectTime(BuildContext context, String Timetype) async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        if (Timetype == "StartTime") {
          _StartTime.text = result.format(context);
        } else {
          _EndTime.text = result.format(context);
        }
      });
    }
  }

  _SetCategory(String Category) {
    this.setState(() {
      this.Category = Category;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Color.fromRGBO(130, 0, 255, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,
                            size: 30, color: Colors.white),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Create New Task",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                         onChanged: (value) {
                     userController.titleController    =   value;
                         },
                 
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      labelText: "Title",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //       left: 20, right: 20, top: 10, bottom: 10),
                //   child: TextFormField(
                //     controller: _Datecontroller,
                //     cursorColor: Colors.white,
                //     style: GoogleFonts.montserrat(
                //       color: Colors.white,
                //       fontSize: 15,
                //     ),
                //     readOnly: true,
                //     decoration: InputDecoration(
                //       labelText: "Date",
                //       suffixIcon: GestureDetector(
                //         onTap: () {
                //           _selectDate(context);
                //         },
                //         child: Icon(
                //           Icons.calendar_month_outlined,
                //           color: Colors.white,
                //         ),
                //       ),
                //       enabledBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(color: Colors.white),
                //       ),
                //       focusedBorder: UnderlineInputBorder(
                //         borderSide: BorderSide(color: Colors.white),
                //       ),
                //       fillColor: Colors.white,
                //       labelStyle: GoogleFonts.montserrat(
                //         color: Colors.white,
                //         fontSize: 10,
                //       ),
                //     ),
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(top: 40),
                  padding:
                      EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
               
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20),
                        child: TextFormField(
                         onChanged: (value) {
                     userController.descriptionController    =   value;
                         },
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 8,
                          cursorColor: Colors.black26,
                          style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          decoration: InputDecoration(
                            labelText: "Description",
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            fillColor: Colors.black26,
                            labelStyle: GoogleFonts.montserrat(
                              color: Colors.black26,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                  
                      SizedBox(
                        height: 100,
                      ),
                      GestureDetector(
                        onTap: () async{
                          await userController.addTasks(widget.id);
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromRGBO(130, 0, 255, 1),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "Create Task",
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
