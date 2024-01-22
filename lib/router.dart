import 'package:go_router/go_router.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/my_food_detail.dart';


final router = GoRouter(initialLocation: '/myfooddetail',
    routes: [
  GoRoute(
    path: '/',
    builder: (context, state) =>  MainPage()

  ),

      GoRoute(
        path: '/myfooddetail',
        builder: (context, state) => MyFoodDetail(registerDate: DateTime.now().toLocal().toString(), remainPeriod: 02, itemImage: 'assets/images/asset.png',),
      ),
]);
