import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../styles/app_text_style.dart';

class NoSubtitleDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String firstButton;

  const NoSubtitleDialog(
      {super.key,
        required this.onTap,
        required this.title,
        required this.firstButton});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: Colors.white,
        ),
        height: 160.h,
        width: 200.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/dialog_cookie.gif',
              width: 70.w,
              height: 70.h,
            ),
            Text(
              title,
              style: AppTextStyle.body15M(),
            ),
        SizedBox(
          height: 16.h),
            SizedBox(
              width: 75.w,
              height: 28.h,
              child: ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8BC6CC)),
                  child: Text(firstButton,
                      style: AppTextStyle.body12R(color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}