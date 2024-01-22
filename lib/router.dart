import 'package:go_router/go_router.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/signup_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MainPage(),
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
