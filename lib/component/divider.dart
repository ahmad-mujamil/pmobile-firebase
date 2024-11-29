import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final double thickness;
  final double spacing;
  final Color lineColor;
  final TextStyle? textStyle;

  const TextDivider({
    Key? key,
    required this.text,
    this.thickness = 1.0,
    this.spacing = 8.0,
    this.lineColor = Colors.grey,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing),
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Expanded(
          child: Divider(
            color: lineColor,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}