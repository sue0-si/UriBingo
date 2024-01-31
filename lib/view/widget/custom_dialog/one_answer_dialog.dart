import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../styles/app_text_style.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  final String firstButton;

  const OneAnswerDialog(
      {super.key,
        required this.onTap,
        required this.title,
        required this.subtitle,
        required this.firstButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        height: 180.h,
        width: 270.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dialog_cookie.gif',
              width: 80,
              height: 80,
            ),
            Text(
              title,
              style: AppTextStyle.body18M(),
            ),
            SizedBox(height: 6.0.h),
            Text(
              subtitle,
              style: AppTextStyle.body12R(),
            ),
            SizedBox(height: 16.0.h),
            ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8BC6CC)),
                child: Text(firstButton,
                    style: AppTextStyle.body12R(color: Colors.white))),
          ],
        ),
      ),
    );
  }
}