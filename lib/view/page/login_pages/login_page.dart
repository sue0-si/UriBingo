import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  StreamSubscription? authStateChanges;

  var messageString = '';
  String token = '';

  void getMyDeviceToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;

    print("내 디바이스 토큰: $token");


  }

  @override
  void initState() {
    super.initState();
    getMyDeviceToken();

    Future.microtask(() {
      var viewmodel = context.read<LoginPageViewModel>();
      // 토큰 갱신 여부 확인
      viewmodel.tokenCheck(token);
      viewmodel.initPreferences().then((value) => emailController.text = value);
    });
    authStateChanges = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        context.go('/main_page', extra: 0);
        return;
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (notification != null) {
        print('Message also contained a notification: ${message.notification}');
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
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
              Row(
                children: [
                  Text(
                    '아이디 저장',
                    style: AppTextStyle.body15M(color: AppColors.mainText),
                  ),
                  Checkbox(
                      value: viewmodel.checkBoxMemory,
                      onChanged: (value) {
                        viewmodel.checkBox(value);
                      })
                ],
              ),
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
                  TextButton(
                      onPressed: () async {
                        await viewmodel.goToPasswordResetPage(context);
                      },
                      child: const Text('비밀번호 찾기')),
                  TextButton(
                      onPressed: () {
                        context.go('/signup', extra: token);
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
