//마이페이지 메뉴

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';

class InkwellRowTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function() onTap;

  const InkwellRowTile(
      {super.key, required this.text, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 40.h,
        child: Row(
          children: [
            Icon(icon, color: AppColors.info),
            SizedBox(width: 16.w),
            Text(text, style: AppTextStyle.body15B()),
          ],
        ),
      ),
    );
  }
}
