import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view/page/main_my_fridge/main_page.dart';
import 'package:leute/view/page/my_food_detail_page/my_food_detail_screen.dart';
import 'package:leute/view/page/login_pages/login_page.dart';
import 'package:leute/view/page/login_pages/signup_page.dart';
import 'package:leute/view/page/register_page/register_page.dart';
import 'package:leute/view/page/my_food_detail_page/my_food_detail_view_model.dart';
import 'package:leute/view_model/register_view_model.dart';

import 'package:leute/view_model/my_page_view_model.dart';

import 'package:leute/view_model/my_food_detail_view_model.dart';
import 'view/page/refrige_detail_page/refrige_detail_screen.dart';
import 'view/page/refrige_pages/add_refrige.dart';
import 'package:leute/view_model/login_page_view_model.dart';
import 'package:leute/view_model/signup_page_view_model.dart';
import 'package:provider/provider.dart';

import 'view_model/add_page_view_model.dart';

final router = GoRouter(initialLocation: '/login', routes: [
  GoRoute(
      path: '/',
      builder: (context, state) => ChangeNotifierProvider(
          create: (_) => MyPageViewModel(), child: MainPage())),
  GoRoute(
      path: '/myfooddetail',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MyFoodDetailViewModel(),
          child: MyFoodDetail(
            myFoodItem: (state.extra as List)[0],
            ourRefrigeItem: (state.extra as List)[1],
          ),
        );
      }),
  GoRoute(
      path: '/login',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => LoginPageViewModel(),
          child: const LoginPage(),
        );
      }),
  GoRoute(
      path: '/signup',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => SignupPageViewModel(),
          child: const SignupPage(),
        );
      }),
  GoRoute(
    path: '/details',
    builder: (context, state) => RefrigeDetailScreen(
      selectedRefrige: state.extra as RefrigeDetail,
    ),
  ),
  GoRoute(
    path: '/addRefrige',
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => AddPageViewModel(),
        child: const AddRefrige(),
      );
    },
  ),

  GoRoute(
      path: '/addMyFood',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => RegisterViewModel(),
          child: RegisterPage(fridgeData: state.extra as List<Object>),
        );
      }),

// GoRoute(
//   path: '/mainScreen',
//   builder: (context, state) => MainScreen(newRefrige: state.extra as RefrigeDetail),
// ), main스크린으로 냉장고 생성 데이터 값을 넘기려고 해본 코드
]);
