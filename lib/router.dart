import 'package:go_router/go_router.dart';
import 'package:leute/refrige_detail/screen/refrige_detail_screen.dart';

import 'view/page/main_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const MainPage(),
  ),
  GoRoute(
    path: '/details',
    builder: (context, state) => RefrigeDetailScreen(refrigeNum: state.extra as int,),
  ),
]);
