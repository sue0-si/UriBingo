import 'package:flutter/material.dart';

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
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: onTap,
            child: Text(firstButton),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); //창 닫기
            },
            child: Text(secondButton),
          ),
        ),
      ],
    );
  }
}
