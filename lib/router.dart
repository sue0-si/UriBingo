import 'package:go_router/go_router.dart';
import 'package:leute/view/page/food_image_zoom.dart';
import 'package:leute/view/page/my_food_detail.dart';

final router = GoRouter(initialLocation: '/',
    routes: [
  GoRoute(
    path: '/',
    builder: (context, state) =>  MyFoodDetail(registerDate: DateTime.now().toLocal().toString(), remainPeriod: 02, itemImage: 'assets/images/asset.png',),
  ),
      GoRoute(
        path: '/foodimagezoom',
        builder: (context, state) => const FoodImageZoom(itemImage: 'assets/images/asset.png'),
      ),
]);
