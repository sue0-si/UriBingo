import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
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
            'Login',
            style: AppTextStyle.header28(color: AppColors.mainText),
          ),
          SizedBox(
            height: 8.h,
          ),
          LoginTextfield(hintText: 'Email'),
          SizedBox(
            height: 8.h,
          ),
          LoginTextfield(hintText: 'Password'),
          SizedBox(
            height: 8.h,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                // 버튼크기조절
                minimumSize:
                    MaterialStateProperty.all(Size(double.infinity, 52.h)),
                //테두리 모양 조절
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.mainButton)),
            child: Text(
              'Login',
              style: AppTextStyle.body20B(color: AppColors.icon),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: Text('아이디 찾기')),
              TextButton(onPressed: () {}, child: Text('비밀번호 찾기')),
              TextButton(onPressed: () {}, child: Text('회원가입'))
            ],
          )
        ],
      ),
    ));
  }
}
