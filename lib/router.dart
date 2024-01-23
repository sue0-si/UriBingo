import 'package:go_router/go_router.dart';
import 'package:leute/custom_buttons/button_test.dart';
import 'package:leute/refrige_detail/data/models/refrige_model.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/my_food_detail.dart';
import 'package:leute/view/page/signup_page.dart';

import 'refrige_detail/screen/refrige_detail_screen.dart';
import 'view/page/register_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
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
    path: '/details',
    builder: (context, state) => RefrigeDetailScreen(selectedRefrige: state.extra as RefrigeDetail,),
  ),
  GoRoute(
    path: '/addMyFood',
    builder: (context, state) => RegisterPage(forFoodData: state.extra as List,),
  ),






  // 커스텀 버튼 화면
  GoRoute(
    path: '/buttonTest',
    builder: (context, state) => const ButtonTest()),

]);

