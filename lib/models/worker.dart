// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
    Account({
       this.email,
       this.firstName,
       this.id,
       this.jobTitle,
       this.lastName,
       this.phone
        // this.dateTime,
    });

    String? firstName;
    String? lastName;
    String? phone;
    String? email;
    String? id;
    String? jobTitle;
  
   

    factory Account.fromJson(DocumentSnapshot json) => Account(
        firstName: json["firstName"],
        lastName: json["lastName"],
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        jobTitle: json["jobTitle"],
      
     
        // dateTime: json["dateTime"]
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "email": email,
        "id": id,
        "jobTitle": jobTitle,
       
 
        // "dateTime":dateTime
    };
}
