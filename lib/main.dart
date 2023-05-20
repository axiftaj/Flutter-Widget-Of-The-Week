import 'package:asif/message_grouping_with_time_stamp.dart';
import 'package:asif/permissions/permission_screen.dart';
import 'package:asif/provider/provider_screen.dart';
import 'package:asif/widgets/animated_list_view_builder_widget.dart';
import 'package:asif/widgets/flutter_fancy_tree_widget.dart';
import 'package:asif/widgets/image_compressor_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
      home: ImageCompressorWidget(),
    );
  }


}
