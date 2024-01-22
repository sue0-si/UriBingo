import 'package:flutter/material.dart';

class FirstCustomDialog extends StatelessWidget {
  const FirstCustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("제목"),
      content: const Text("내용"),
      actions: <Widget>[
        Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); //창 닫기
            },
            child: const Text("네"),
          ),
        ),
        Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); //창 닫기
            },
            child: const Text("아니요"),
          ),
        ),
      ],
    );
  }
}
