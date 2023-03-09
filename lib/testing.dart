import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:keep_keyboard_popup_menu/keep_keyboard_popup_menu.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        FlutterAppBadger.isAppBadgeSupported().then((value){
          print(value);
        });
        FlutterAppBadger.updateBadgeCount(2);
      }),
      appBar: AppBar(
        title: Text('KeepKeyboardPopupMenuButton'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
              ),
            ),
          ),
          KeepKeyboardPopupMenuButton(
            iconSize:24.0 ,
            menuBuilder: (context, closePopup) => Container(
              color: Colors.teal,
              child: InkWell(
                onTap: closePopup,
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Text(
                    "Custom Menu Widget",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ), ],
      ),
    );
  }
}