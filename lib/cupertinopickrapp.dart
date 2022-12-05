import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kItemExtent = 32.0;




class CupertinoPickerExample extends StatefulWidget {
  const CupertinoPickerExample({super.key});

  @override
  State<CupertinoPickerExample> createState() => _CupertinoPickerExampleState();
}

class _CupertinoPickerExampleState extends State<CupertinoPickerExample> {

  int _inches = 0;
  int _feet = 0;

   List<int> _inchesList = <int>[
    1,
    2,
    3,
    4,
    5,6,7,8,9,10,11
  ];

  List<int> _feetList = <int>[

    4,
    5,6,7,8
  ];


  Future<void> _showMyDialog() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {

        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.red
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 50,
                          scrollController: FixedExtentScrollController(initialItem: _inches),
                          children: List<Widget>.generate(_feetList.length, (int index) {
                            return Center(
                              child: Text(
                                _feetList[index].toString(),
                              ),
                            );
                          }),
                          onSelectedItemChanged: (value) {
                            setState(() {
                              _feet = value;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 50,
                          looping: true,
                          scrollController: FixedExtentScrollController(initialItem: _inches),
                          children: List<Widget>.generate(_inchesList.length, (int index) {
                            return Center(
                              child: Text(
                                _inchesList[index].toString(),
                              ),
                            );
                          }),
                          onSelectedItemChanged: (value) {
                            setState(() {
                              _inches = value;
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );


      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Selected fruit: '),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text( _feetList[_feet].toString()+"'"),
                 SizedBox(width: 12,),
                 Text( _inchesList[_inches].toString()+'"'),

               ],
             ),

            Center(
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                // Display a CupertinoPicker with list of fruits.
                onPressed: () {
                  _showMyDialog();
                },
                // This displays the selected fruit name.
                child: Text(
                  'Click to pick height',
                  style: const TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

