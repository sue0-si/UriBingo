import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/view/page/discard_foods_page/discard_food_detail_page.dart';
import 'package:leute/view/page/discard_foods_page/discard_foods_page.dart';
import 'package:leute/view/page/login_pages/change_password_page.dart';
import 'package:leute/view/page/login_pages/group_setting_page.dart';
import 'package:leute/view/page/login_pages/login_page.dart';
import 'package:leute/view/page/login_pages/signup_page.dart';
import 'package:leute/view/page/main_my_fridge/main_page.dart';
import 'package:leute/view/page/my_food_detail_page/my_food_detail_screen.dart';
import 'package:leute/view/page/refrige_detail_page/refrige_detail_screen.dart';

import 'package:leute/view/page/register_page/register_page.dart';
import 'package:leute/view_model/discard_foods_view_model.dart';
import 'package:leute/view_model/group_setting_page_view_model.dart';
import 'package:leute/view_model/login_page_view_model.dart';
import 'package:leute/view_model/my_page_view_model.dart';
import 'package:leute/view_model/signup_page_view_model.dart';
import 'package:provider/provider.dart';

import 'view/page/refrige_pages/add_refrige.dart';
import 'view/page/refrige_pages/edit_refrige.dart';
import 'view/page/splash_page/splash_page.dart';
import 'view_model/add_page_view_model.dart';
import 'view_model/my_food_detail_view_model.dart';
import 'view_model/register_view_model.dart';

final router = GoRouter(initialLocation: '/splash_page', routes: [

  GoRoute(
      path: '/main_page',
      builder: (context, state) => ChangeNotifierProvider(
          create: (_) => MyPageViewModel(),
          child: MainPage(currentPageIndex: state.extra as int))),

  // GoRoute(path: '/allmyfoods', builder: (context, state) => const MyFridge()),

  // 나의음식 상세 페이지
  GoRoute(
      path: '/myfooddetail',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MyFoodDetailViewModel(),
          child: MyFoodDetail(
            myFoodItem: (state.extra as List)[0],
            ourRefrigItem: (state.extra as List)[1],
          ),
        );
      }),

  //로그인 페이지
  GoRoute(
      path: '/login',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => LoginPageViewModel(),
          child: const LoginPage(),
        );
      }),

  // 회원가입 페이지
  GoRoute(
      path: '/signup',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => SignupPageViewModel(),
          child: const SignupPage(),
        );
      }),

  // 그룹관리 페이지
  GoRoute(
      path: '/groupSetting',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => GroupSettingPageViewModel(),
          child: const GroupSettingPage(),
        );
      }),

  // 냉장고 상세 페이지
  GoRoute(
    path: '/details',
    builder: (context, state) => RefrigeDetailScreen(
      selectedRefrige: (state.extra as List)[0],
      selectedIndex: (state.extra as List)[1],
    ),
  ),

  // 스플래쉬 페이지
  GoRoute(
    path: '/splash_page',
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => LoginPageViewModel(),
        child: SplashScreen(),
      );
    },
  ),

  //냉장고 추가 페이지
  GoRoute(
    path: '/addRefrige',
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => AddPageViewModel(),
        child: AddRefrige(
          currentUser: state.extra as UserModel,
        ),
      );
    },
  ),

  // 냉장고 수정페이지
  GoRoute(
    path: '/editRefrige',
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => AddPageViewModel(),
        child: EditRefrige(
          seletedRefrige: (state.extra as List)[0],
          currentUser: (state.extra as List)[1],
        ),
      );
    },
  ),

  // 음식 추가페이지
  GoRoute(
      path: '/addMyFood',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => RegisterViewModel(),
          child: RegisterPage(fridgeData: state.extra as List<Object>),
        );
      }),

  // 폐기할 음식 페이지
  GoRoute(
      path: '/discardPage',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => DiscardFoodsViewModel(),
          child: const DiscardFoods(),
        );
      }),

  // 폐기 음식 상세 페이지
  GoRoute(
      path: '/discardFoodDetail',
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => MyFoodDetailViewModel(),
          child: DiscardFoodDetail(
            myFoodItem: (state.extra as List)[0],
            ourRefrigItem: (state.extra as List)[1],
          ),
        );
      }),

  // 비밀번호 변경 페이지
  GoRoute(
    path: '/changePassword',
    builder: (context, state) {
      return ChangeNotifierProvider(
        create: (_) => LoginPageViewModel(),
        child: const ChangePasswordPage(),
      );
    },
  )

  // GoRoute(
  //     path: '/myFridge',
  //     builder: (context, state) {
  //       return ChangeNotifierProvider(
  //         create: (_) => MyFridgeViewModel(),
  //         child: const MyFridge(),
  //       );
  //     }),

  // 냉장실 가는 라우터
  // GoRoute(
  //     path: '/refrigeDetail',
  //     builder: (context, state) {
  //       return ChangeNotifierProvider(
  //         create: (context) =>
  //             RefrigeCompViewModel(state.extra as RefrigeDetail),
  //         child: RefrigeCompScreen(
  //           selectedRefrige: state.extra as RefrigeDetail,
  //         ),
  //       );
  //     }),
// 냉동실 가는 라우터
//   GoRoute(
//       path: '/freezerDetail',
//       builder: (context, state) {
//         return ChangeNotifierProvider(
//           create: (context) =>
//               FreezerCompViewModel(state.extra as RefrigeDetail),
//           child: FreezerCompScreen(
//             selectedRefrige: state.extra as RefrigeDetail,
//           ),
//         );
//       }),

// GoRoute(
//   path: '/mainScreen',
//   builder: (context, state) => MainScreen(newRefrige: state.extra as RefrigeDetail),
// ), main스크린으로 냉장고 생성 데이터 값을 넘기려고 해본 코드
]);
