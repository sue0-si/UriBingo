import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  child: Text(
                    '냉장고 이름',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '냉장고 칸수',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '냉동고 칸수',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '보관기간',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '연장가능기간',
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '추가하기',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
