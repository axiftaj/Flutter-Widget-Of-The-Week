


import 'package:flutter/material.dart';

class SizeBoxExtensionWidget extends StatelessWidget {
  const SizeBoxExtensionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            const ContainerWidget(),
            // This is size box extension which will return SizedBox(height: 100)
            50.ph,
            const ContainerWidget(),
            50.ph,
           Row(
             children: [
               const Expanded(child: ContainerWidget()),
               100.pw,
               const  Expanded(child:  ContainerWidget()),
             ],
           )
          ],
        ),
      ),
    );
  }
}

// creating extension for Size box on number to return double value
extension Padding on num {
  SizedBox get ph => SizedBox(height:toDouble() ,);
  SizedBox get pw => SizedBox(width:toDouble() ,);
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100,
      width: double.infinity,
      color: Colors.red,
    );
  }
}


