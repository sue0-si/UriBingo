import 'package:go_router/go_router.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/my_food_detail.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/signup_page.dart';

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

]);
