import 'package:go_router/go_router.dart';
import 'package:leute/refrige_detail/screen/refrige_detail.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const RefrigeDetail(refrigeNum: 1),
  ),
]);
