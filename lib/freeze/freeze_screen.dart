

import 'package:asif/freeze/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart' ;
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
        var person = Person(firstName: 'John', lastName: 'Smith');

        var john2 = UserModel(firstName: 'John', lastName: 'Smith');

        print( john.copyWith(firstName: 'as'));
         print(john.firstName.toString());

        print(person == john2);
      }),
    );
  }
}


class Person{
  String firstName ;
  String lastName ;

  Person({required this.firstName,required this.lastName}) ;

}

