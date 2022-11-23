import 'package:asif/custom_animation.dart';
import 'package:asif/custom_navifation.dart';
import 'package:asif/html_editor.dart';
import 'package:asif/internet_connection.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HtmlEditor(),
    );
  }


}
