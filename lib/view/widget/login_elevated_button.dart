import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';

class LoginElevatedButton extends StatelessWidget {
  final String childText;
  const LoginElevatedButton({super.key, required this.childText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
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
  }
}
