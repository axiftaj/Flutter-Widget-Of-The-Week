


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
            Text(
          'Hello, World!',
          style: Theme.of(context).textTheme.headline4,
          ).center(),
            20.ph,//I
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
extension PaddingHeight on num {
  SizedBox get ph => SizedBox(height:toDouble() ,);
  SizedBox get pw => SizedBox(width:toDouble() ,);
}

extension WidgetExtension on Widget{
  Widget  horizontalPadding(double padding)=>Padding(
      padding:EdgeInsets.symmetric(horizontal: padding),
      child:this);

  Widget center()=> Center(child:this);
}

extension MediaQueryValues on BuildContext {
  double get mediaQueryWidth => MediaQuery.of(this).size.width;
  double get mediaQueryHeight => MediaQuery.of(this).size.height ;
}


class ContainerWidget extends StatelessWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 50,
      width: 100,
      color: Colors.red,
    );
  }
}


