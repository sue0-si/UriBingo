import 'package:flutter/material.dart';

import '../../../styles/app_text_style.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String firstButton;

  const OneAnswerDialog(
      {super.key,
      required this.onTap,
      required this.title,
      required this.firstButton});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppTextStyle.body18R()),
      actions: <Widget>[
        ElevatedButton(
          onPressed: onTap,
          child: Text(firstButton, style: AppTextStyle.body14R()),
        ),
      ],
    );
  }
}
