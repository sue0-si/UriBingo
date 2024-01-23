import 'package:go_router/go_router.dart';
import 'package:leute/refrige_detail/screen/refrige_detail.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/main_screen.dart';
import 'package:leute/view/page/my_food_detail.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/signup_page.dart';

import 'remote/add_refrige.dart';

final router = GoRouter(initialLocation: '/addRefrige', routes: [
  GoRoute(path: '/', builder: (context, state) => MainPage()),
  GoRoute(
    path: '/myfooddetail',
    builder: (context, state) => MyFoodDetail(
      registerDate: DateTime.now().toLocal().toString(),
      remainPeriod: 02,
      itemImage: 'assets/images/asset.png',
    ),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/signup',
    builder: (context, state) => const SignupPage(),
  ),
  GoRoute(
    path: '/addRefrige',
    builder: (context, state) => const addRefrige(),
  ),
  // GoRoute(
  //   path: '/mainScreen',
  //   builder: (context, state) => MainScreen(newRefrige: state.extra as RefrigeDetail),
  // ), main스크린으로 냉장고 생성 데이터 값을 넘기려고 해본 코드
]);
