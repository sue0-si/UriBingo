import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../router.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future.delayed(const Duration(seconds: 3))
    //     .then((value) => GoRouter.of(context).go('/login'));
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Tmoney',
// useMaterial3: false,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF325c6a)),
        ),
        routerConfig: router,
      ),
    );
  }
}
