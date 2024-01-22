import 'package:go_router/go_router.dart';
import 'package:leute/view/page/my_refrige_page.dart';

final router = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) =>  MyRefrigePage(registerDate: DateTime.now().toLocal().toString(), remainPeriod: 02,),
  ),
]);
