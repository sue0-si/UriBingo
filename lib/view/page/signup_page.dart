import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_elevated_button.dart';
import 'package:leute/view/widget/login_textfield.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('이메일', style: AppTextStyle.body16B()),
            LoginTextfield(hintText: 'email@email.com'),
            SizedBox(height: 8.h),
            Text('비밀번호', style: AppTextStyle.body16B()),
            LoginTextfield(hintText: '****'),
            SizedBox(height: 8.h),
            Text('비밀번호 확인', style: AppTextStyle.body16B()),
            LoginTextfield(hintText: '****'),
            SizedBox(height: 8.h),
            Text('이름', style: AppTextStyle.body16B()),
            LoginTextfield(hintText: '홍길동'),
            SizedBox(height: 8.h),
            Text('사원번호', style: AppTextStyle.body16B()),
            LoginTextfield(hintText: '12-3456'),
            SizedBox(height: 8.h),
            LoginElevatedButton(childText: '가입하기'),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('이미 계정이 있습니까?'),
              TextButton(
                  onPressed: () {
                    context.push(Uri(path: '/login').toString());
                  },
                  child: Text('로그인하기'))
            ])
          ],
        ),
      ),
    );
  }
}
