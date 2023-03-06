

import 'dart:io';

import 'package:flutter/material.dart';

class TestingScreen extends StatefulWidget {
  const TestingScreen({Key? key}) : super(key: key);

  @override
  State<TestingScreen> createState() => _TestingScreenState();
}

class _TestingScreenState extends State<TestingScreen> {


  final List<dynamic> _listItems =   [
    '👍',
    '❤️',
    '😂',
    '😱',
    '😢',
    '🙏',
    ''
  ];
  final textEditionController = TextEditingController() ;

  GlobalKey key = GlobalKey(); //


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
            ),
            TextButton(
              key: key,
                onPressed: (){


              RenderBox box = context!.findRenderObject() as RenderBox;
              Offset position = box.localToGlobal(Offset.zero); //this is global position

              final double left = position.dx;
              final double top = position.dy;

              showMenu(context: context,
                elevation: 1, shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40.0))
                ),
                position: RelativeRect.fromLTRB(
                  left,
                  top - (20 + 8 * 2 + 20.0) - (8 * 2),
                  left,
                  top -  top - 8 * 3,
                ),
                items: [
                  PopupMenuItem<int>(
                    value: 0,
                    padding: EdgeInsets.zero,
                    enabled: true,
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.white,

                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: _listItems.map((e) => Padding(
                            padding: const EdgeInsets.only(left: 10 ,right: 0.0, top: 10, bottom: 10),
                            child: e.toString() == '' ?
                            GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const CircleAvatar(
                                radius: 13,
                                child: Icon(Icons.add),
                              ),
                            )
                                :
                            GestureDetector(
                                onTap: (){
                                  //checking if i'm sender then send my user id else send recepient user ud

                                  Navigator.pop(context);

                                },
                                child: Text(e ,
                                  style: const TextStyle(fontSize: 22),
                                  strutStyle:  StrutStyle(
                                    forceStrutHeight: Platform.isAndroid ? false : true,
                                  ),)),
                          )).toList(),
                        ),
                      ),
                    ),
                  ),
                ] ,
                color: Colors.white,

              );
            },
                child: Text('Click'))
          ],
        ),
      ),
    );
  }
}


