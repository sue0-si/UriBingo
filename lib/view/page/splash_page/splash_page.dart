import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../styles/app_text_style.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
      splashIconSize: 500,
      duration: 4700,
      splashTransition: SplashTransition.fadeTransition,
      nextScreen: SplashScreen(),

//curve: Curves.easeIn,
    );
  }
}
