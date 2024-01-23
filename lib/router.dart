import 'package:go_router/go_router.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/my_food_detail.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/signup_page.dart';
import 'refrige_detail/screen/refrige_detail_screen.dart';

final router = GoRouter(initialLocation: '/', routes: [
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
    builder: (context, state) => RefrigeDetailScreen(refrigeNum: state.extra as int,),
  ),

]);
