

import 'package:flutter/material.dart';

class CustomButtonScreen extends StatefulWidget {
  const CustomButtonScreen({super.key});

  @override
  State<CustomButtonScreen> createState() => _CustomButtonScreenState();
}

class _CustomButtonScreenState extends State<CustomButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomButton(label: 'Login', onPressed: (){}),
            SizedBox(height: 20,),
            GradientButton(label: 'Regi', onPressed: () {  }, gradientColors: [Colors.red , Colors.pink],)
          ],
        ),
      ),
    );
  }
}


class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}


class GradientButton extends CustomButton {
  final List<Color> gradientColors;

  const GradientButton({
    Key? key,
    required String label,
    required VoidCallback onPressed,
    required this.gradientColors,
  }) : super(
    key: key,
    label: label,
    onPressed: onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shadowColor: Colors.transparent,
          
        ),
        child: Text(label),
      ),
    );
  }
}
