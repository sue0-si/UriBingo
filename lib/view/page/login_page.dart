import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_elevated_button.dart';
import 'package:leute/view/widget/login_textfield.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '로그인',
            style: AppTextStyle.header28(color: AppColors.mainText),
          ),
          SizedBox(height: 8.h),
          LoginTextfield(hintText: '이메일'),
          SizedBox(height: 8.h),
          LoginTextfield(hintText: '비밀번호'),
          SizedBox(height: 8.h),
          LoginElevatedButton(
            childText: '로그인하기',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: Text('아이디 찾기')),
              TextButton(onPressed: () {}, child: Text('비밀번호 찾기')),
              TextButton(
                  onPressed: () {
                    context.push(Uri(path: '/signup').toString());
                  },
                  child: Text('회원가입')),
            ],
          )
        ],
      ),
    ));
  }
}
