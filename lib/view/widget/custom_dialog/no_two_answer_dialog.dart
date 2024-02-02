import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_style.dart';

class NoTwoAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  final String firstButton;
  final String secondButton;

  const NoTwoAnswerDialog({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.firstButton,
    required this.secondButton,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        height: 200.h,
        width: 270.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dialog_carrot.gif',
              width: 70.w,
              height: 70.h,
            ),
            Text(
              title,
              style: AppTextStyle.body18M(),
            ),
            SizedBox(height: 6.h),
            Text(
              subtitle,
              style: AppTextStyle.body12R(),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 90.w,
                  height: 35.h,
                  child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8BC6CC)),
                      child: Text(firstButton,
                          style: AppTextStyle.body12R(color: Colors.white))),
                ),
                SizedBox(width: 14.w),
                SizedBox(
                  width: 90.w,
                  height: 35.h,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop(); //창 닫기
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200),
                      child: Text(secondButton, style: AppTextStyle.body12R())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
