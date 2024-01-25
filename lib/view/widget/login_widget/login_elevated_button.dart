import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_buttons/first_custom_button.dart';

class LoginElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String childText;
  const LoginElevatedButton(
      {super.key, required this.childText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          // 버튼크기조절
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 52.h)),
          //테두리 모양 조절
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all(AppColors.mainButton)),
      child: Text(
        childText,
        style: AppTextStyle.body20B(color: AppColors.icon),
      ),
    );
    //     NiceButtons(
    //   stretch: true,
    //   gradientOrientation: GradientOrientation.Horizontal,
    //   onTap: onPressed,
    //   child: Text(
    //     childText,
    //     style: TextStyle(color: Colors.white, fontSize: 18),
    //   ),
    // );
  }
}
