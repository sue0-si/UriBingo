import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_widget/login_elevated_button.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';
import 'package:leute/view/widget/login_widget/password_textfield.dart';
import 'package:leute/view_model/login_page_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required String title});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamSubscription? authStateChanges;

  @override
  void initState() {
    super.initState();
    authStateChanges = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        context.go('/', extra: 0);
        return;
      }
    });
  }

  @override
  void dispose() {
    authStateChanges?.cancel();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewmodel = context.watch<LoginPageViewModel>();
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                '로그인',
                style: AppTextStyle.header28(color: AppColors.mainText),
              ),
              SizedBox(height: 8.h),
              LoginTextfield(
                hintText: '이메일',
                controller: emailController,
                validator: viewmodel.emailValidator,
              ),
              SizedBox(height: 8.h),
              PasswordTextfield(
                hintText: '비밀번호',
                controller: passwordController,
                validator: viewmodel.passwordValidator,
              ),
              SizedBox(height: 8.h),
              LoginElevatedButton(
                  childText: '로그인하기',
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      viewmodel.handleLoginButton(
                          email: emailController.text,
                          password: passwordController.text,
                          context: context);
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: const Text('아이디 찾기')),
                  TextButton(onPressed: () {}, child: const Text('비밀번호 찾기')),
                  TextButton(
                      onPressed: () {
                        context.push(Uri(path: '/signup').toString());
                      },
                      child: const Text('회원가입')),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
