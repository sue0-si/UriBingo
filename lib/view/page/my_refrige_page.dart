import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';

class MyRefrigePage extends StatefulWidget {

  final String registerDate;
  final int remainPeriod;

  const MyRefrigePage({super.key,
      required this.registerDate,
      required this.remainPeriod,
    });

  @override
  State<MyRefrigePage> createState() => _MyRefrigePageState();
}

class _MyRefrigePageState extends State<MyRefrigePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Icon(Icons.arrow_back)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 250,
            width: 300,
            color: Colors.purple,
          ),
          const SizedBox(height: 32),
          Center(
            child: Container(
              height: 250,
              width: 300,
              child: Column(
                children: [
                   Row(
                    children: [
                      Text('등록일 : ${widget.registerDate}'),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text('남은기간: ${widget.remainPeriod}일'),
                      const Spacer(),
                      ElevatedButton(onPressed: () {}, child: const Text('연장하기'))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
