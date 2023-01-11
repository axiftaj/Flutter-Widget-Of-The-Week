import 'package:asif/dating_app/widgets/background_curve_widget.dart';
import 'package:asif/dating_app/widgets/cards_stack_widget.dart';
import 'package:asif/super_editor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dumy_screen.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DumyScreen(),
    );
  }


}
