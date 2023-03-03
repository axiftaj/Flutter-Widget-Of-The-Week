


import 'package:flutter/material.dart';

class SizeBoxExtensionWidget extends StatelessWidget {
  const SizeBoxExtensionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            20.ph,
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),
            20.ph,
            SizedBox(height: 50,),
            Container(
              height: 100,
              width: double.infinity,
              color: Colors.red,
            ),

          ],
        ),
      ),
    );
  }
}

extension Padding on num {

  SizedBox get ph => SizedBox(height: toDouble(),) ;
  SizedBox get pw => SizedBox(width: toDouble(),) ;

}
