import 'package:flutter/material.dart';

class FirstCustomButton extends StatelessWidget {
  final Function()? onTap;
  final String? btnText;
  final Color? firstColor;
  final Color? secondColor;


  const FirstCustomButton({super.key,  required this.onTap, this.btnText, this.firstColor, this.secondColor});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
