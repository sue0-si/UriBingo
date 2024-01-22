import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view/page/food_image_zoom.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/my_food_detail.dart';
import 'package:leute/view/page/login_page.dart';
import 'package:leute/view/page/main_page.dart';
import 'package:leute/view/page/signup_page.dart';
import 'package:leute/view_model/login_page_view_model.dart';
import 'package:leute/view_model/signup_page_view_model.dart';
import 'package:provider/provider.dart';

final router = GoRouter(initialLocation: '/login', routes: [
  GoRoute(path: '/', builder: (context, state) => MainPage()),
  GoRoute(
    path: '/foodimagezoom',
    builder: (context, state) =>
        const FoodImageZoom(itemImage: 'assets/images/asset.png'),
  ),
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
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => LoginPageViewModel(),
          child: LoginPage(),
        );
      }),
  GoRoute(
      path: '/signup',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => SignupPageViewModel(),
          child: SignupPage(),
        );
      }),
]);
