
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomNavigation extends StatefulWidget {
  const CustomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: TextButton(onPressed: (){
       Navigator.of(context).push(
         PageRouteBuilder(pageBuilder: (context, animation, a){
           return ScreenThree();
         }, opaque: false)
       );
      }, child: Text('Click'))),
    );
  }
}


//transition testing


class ScreenThree extends StatelessWidget {
  const ScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return TweenAnimationBuilder(
                tween: Tween(begin: 0, end: 1.0),
                duration: const Duration(milliseconds: 800),
                builder: (context, value, child) {
                  return ShaderMask(
                      shaderCallback: (rect) {
                        return RadialGradient(
                            radius: double.parse(value.toString()) * 4.0 ,
                            colors: [Colors.white, Colors.white, Colors.transparent, Colors.transparent],
                            stops: [1.0, 0.6, 0.55, 0.0,],
                            center: const FractionalOffset(0.95, 0.95))
                            .createShader(rect);
                      },
                      child: Container(
                          height: double.infinity,
                          color: Colors.red,
                          child: const Center(child: Text('Asif Taj'))));
                });
          },
        )
    );
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('ScreenTwo'),
      ),
    );
  }
}
