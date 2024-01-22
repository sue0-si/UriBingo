import 'package:go_router/go_router.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/main_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginPage(),
  ),
]);
