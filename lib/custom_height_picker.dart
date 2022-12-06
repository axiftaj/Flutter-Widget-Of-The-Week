import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomerHeightPicker extends StatefulWidget {
  const CustomerHeightPicker({super.key});

  @override
  State<CustomerHeightPicker> createState() => _CustomerHeightPickerState();
}

class _CustomerHeightPickerState extends State<CustomerHeightPicker> {

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
          title: const Text('Height Picker'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.transparent
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Theme(
                          data: ThemeData.light().copyWith(
                              primaryColor: Colors.transparent ,
                              cardColor: Colors.transparent,
                              backgroundColor: Colors.transparent ,
                            dividerColor: Colors.transparent ,
                            selectedRowColor:  Colors.transparent
                          ),
                          child: CupertinoPicker(
                            useMagnifier: true,
                            itemExtent: 40,
                            // if you wan to remove background over lay color uncomment this
                            //   selectionOverlay: CupertinoPickerDefaultSelectionOverlay(background: Colors.transparent,),
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
              child: const Text('Ok'),
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
            const Text('Initial Value: '),
            SizedBox(height: 20,),
             Row(
               crossAxisAlignment: CrossAxisAlignment.center,
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text( _feetList[_feet].toString()+"'" , style: TextStyle(fontSize: 40),),
                 SizedBox(width: 12,),
                 Text( _inchesList[_inches].toString()+'"' ,  style: TextStyle(fontSize: 40)),

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

