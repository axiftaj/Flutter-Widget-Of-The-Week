

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  State<DumyScreen> createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.snackbar(
            'a',
            '',
            messageText: Text('' , style: TextStyle(fontSize: 0, height: 0),),
            titleText: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                children: [
                  Expanded(child: Text('Click to copy the code' , style: TextStyle(color: Colors.white),)) ,
                  GestureDetector(
                      onTap: (){
                        Clipboard.setData(ClipboardData(text: "21344"));
                      },
                      child: Text('Copy' , style:  TextStyle(color: Colors.white),)),
                  SizedBox(width: 20,),
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Icon(Icons.close, color: Colors.white,))
                ],
              ),
            ),
            duration: Duration(minutes: 2),
            backgroundColor: Colors.black,
            snackPosition: SnackPosition.BOTTOM
          );
        },
      ),
    );
  }
}
