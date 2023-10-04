

import 'package:asif/freeze/person.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' ;

class FreezeScreen extends StatefulWidget {
  const FreezeScreen({Key? key}) : super(key: key);

  @override
  State<FreezeScreen> createState() => _FreezeScreenState();
}

class _FreezeScreenState extends State<FreezeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        var john = UserModel(firstName: 'John', lastName: 'Smith');
        var john2 = UserModel(firstName: 'John', lastName: 'Smith');


        Map<String, dynamic> data = {
          'firstName' : 'Asif Taj' ,
          'lastName' : 'Taj' ,
          'age' : 20
        };

        Map<String, dynamic> copyData = {
          'firstName' : 'Hello world' ,
          'lastName' : 'Taj' ,
          'age' : 20
        };
        PersonModel personModel = PersonModel.fromJson(data) ;
        personModel =   personModel.copyWith(firstName: 'hello world' , lastName: 'Dart' , age: 22);

        if (kDebugMode) {
          print(personModel);
        }

        // if (kDebugMode) {
        //   print("First name:${personModel.firstName} "
        //       "Last name:${personModel.lastName} "
        //       "age ${personModel.age}");
        // }


        //print(person == john2);
      }),
    );
  }
}



class PersonModel {
  String? firstName;
  String? lastName;
  int? age;

  PersonModel({this.firstName, this.lastName, this.age});

  PersonModel.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    return data;
  }


  PersonModel copyWith({
    String? firstName,
    String? lastName,
    int? age
  }){
    return PersonModel(
      firstName: firstName,
      lastName: lastName ,
      age: age
    );
  }

  @override
  String toString() {
    return 'Person(firstName: $firstName, lastName: $lastName , age:$age)';
  }
}