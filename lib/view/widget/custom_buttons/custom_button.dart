import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.width,
      required this.height,
      required this.backgroundColor,
        required this.text,
        this.textStyle,
        required this.onTap,});

  final String text;
  final double width;
  final double height;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onTap,
        style:
            ElevatedButton.styleFrom(backgroundColor: backgroundColor, padding: EdgeInsets.zero),
        child: Text(
          text,
          style: textStyle,
        ),
      ),
    );
  }
}
