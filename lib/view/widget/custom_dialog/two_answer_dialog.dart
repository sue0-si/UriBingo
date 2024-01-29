import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_style.dart';

class TwoAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String subtitle;
  final String firstButton;
  final String secondButton;

  const TwoAnswerDialog(
      {super.key,
      required this.onTap,
      required this.title,
        required this.subtitle,
      required this.firstButton,
      required this.secondButton,
      TextStyle? titleStyle, });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title:  Text(title, style: AppTextStyle.body18R()),
      content: Text(subtitle, style: AppTextStyle.body14M()),
      actions: <Widget>[
        Container(
          child: TextButton(
            onPressed: onTap,
            child:  Text(firstButton, style: AppTextStyle.body14R()),
          ),
        ),
        Container(
          child: TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(); //창 닫기
            },
            child:  Text(secondButton, style: AppTextStyle.body14R()),
          ),
        ),
      ],
    );
  }
}
