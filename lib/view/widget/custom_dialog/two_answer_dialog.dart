import 'package:flutter/material.dart';
import 'package:leute/styles/app_text_style.dart';

class TwoAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String firstButton;
  final String secondButton;

  const TwoAnswerDialog(
      {super.key,
      required this.onTap,
      required this.title,
      required this.firstButton,
      required this.secondButton,
      TextStyle? titleStyle});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title, style: AppTextStyle.body14R()),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: onTap,

            child:  Text(firstButton, style: AppTextStyle.body12R()),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop(); //창 닫기
            },
            child:  Text(secondButton, style: AppTextStyle.body12R()),
          ),
        ),
      ],
    );
  }
}
