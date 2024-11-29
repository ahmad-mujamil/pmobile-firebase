import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final MaterialColor colorStart;
  final MaterialColor colorEnd;


  GradientButton({required this.onPressed, required this.text,this.colorStart = Colors.blue,this.colorEnd = Colors.green});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: [colorStart,colorEnd], // Define gradient colors here
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}