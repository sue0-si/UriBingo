import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_style.dart';

class TwoAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  final String firstButton;
  final String secondButton;

  const TwoAnswerDialog({
    super.key,
    required this.onTap,
    required this.title,
    required this.subtitle,
    required this.firstButton,
    required this.secondButton,
    TextStyle? titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        height: 180.h,
        width: 270.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dialog_cookie.gif',
              width: 80.w,
              height: 80.h,
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
                ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8BC6CC)),
                    child: Text(firstButton,
                        style: AppTextStyle.body12R(color: Colors.white))),
                SizedBox(width: 16.w),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop(); //창 닫기
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade200),
                    child: Text(secondButton, style: AppTextStyle.body12R())),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
