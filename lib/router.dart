import 'package:go_router/go_router.dart';
import 'package:leute/refrige_detail/data/models/refrige_model.dart';

import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/main_screen.dart';
import 'package:leute/view/page/my_food_detail.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/signup_page.dart';
import 'refrige_detail/screen/refrige_detail_screen.dart';
import 'remote/add_refrige.dart';

final router = GoRouter(initialLocation: '/myfooddetail', routes: [
  GoRoute(path: '/', builder: (context, state) => MainPage()),

  GoRoute(
    path: '/myfooddetail',
    builder: (context, state) => const MyFoodDetail(),
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
    path: '/details',
    builder: (context, state) => RefrigeDetailScreen(
      selectedRefrige: state.extra as RefrigeDetail,
    ),
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
