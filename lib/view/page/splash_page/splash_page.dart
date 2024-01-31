import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';

import '../login_pages/login_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3))
        .then((value) => GoRouter.of(context).go('/login'));
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/images/refrigerator.gif',
            ),
          ),
          Text(
            'Uribingo',
            style: AppTextStyle.body15R(
              color: Colors.orangeAccent,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      nextScreen: const LoginPage(),
      duration: 50,
      splashIconSize: 500,
      splashTransition: SplashTransition.fadeTransition,

      //curve: Curves.easeIn,
    );
  }
}
