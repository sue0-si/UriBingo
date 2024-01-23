import 'package:flutter/material.dart';

class OneAnswerDialog extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String firstButton;
  const OneAnswerDialog({super.key, required this.onTap, required this.title, required this.firstButton});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(title),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: onTap,
            child:  Text(firstButton),
          ),
        ),
      ],
    );
  }
}
