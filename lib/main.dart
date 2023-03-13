import 'package:asif/location_permission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'image_compressor_widget.dart';
import 'message_grouping_with_time_stamp.dart';


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
      home: MessageGroupingWithTimeStamp(),
    );
  }


}
