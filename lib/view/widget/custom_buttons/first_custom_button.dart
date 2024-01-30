import 'package:flutter/material.dart';
import 'package:neumorphic_button/neumorphic_button.dart';

class SuperNeumorphicButton extends StatelessWidget {
  void Function() onTap;
  double height;
  double width;
  Widget child;
  EdgeInsets? padding;

  SuperNeumorphicButton({
    super.key,
    required this.onTap,
    required this.height,
    required this.width,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onTap: onTap,
      borderRadius: 12,
      bottomRightShadowBlurRadius: 15,
      bottomRightShadowSpreadRadius: 1,
      borderWidth: 5,
      backgroundColor: Colors.grey.shade300,
      topLeftShadowBlurRadius: 15,
      topLeftShadowSpreadRadius: 1,
      topLeftShadowColor: Colors.white,
      bottomRightShadowColor: Colors.grey.shade500,
      height: height,
      width: width,
      padding: padding,
      bottomRightOffset: const Offset(4, 4),
      topLeftOffset: const Offset(-4, -4),
      child: child,
    );
  }
}
