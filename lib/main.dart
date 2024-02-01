import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/page/splash_page/splash_page.dart';

import 'firebase_options.dart';

void main()  {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Container(
            height: 300,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.6,
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
