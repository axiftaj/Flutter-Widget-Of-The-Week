

import 'package:asif/freeze/person.dart';
import 'package:flutter/material.dart';

class FreezeScreen extends StatefulWidget {
  const FreezeScreen({Key? key}) : super(key: key);

  @override
  State<FreezeScreen> createState() => _FreezeScreenState();
}

class _FreezeScreenState extends State<FreezeScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){

        var john = UserModel(firstName: 'John', lastName: 'Smith');
        var john2 = UserModel(firstName: 'John', lastName: 'Smith');

        print( john.copyWith(firstName: 'as'));
         print(john.firstName.toString());

        print(john == john2);
      }),
    );
  }
}




