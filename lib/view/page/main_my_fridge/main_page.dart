// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:leute/styles/app_text_colors.dart';
// import 'package:leute/styles/app_text_style.dart';
// import 'package:leute/view/page/login_pages/my_page.dart';
// import 'package:leute/view_model/main_screen_view_model.dart';
// import 'package:leute/view_model/my_fridge_view_model.dart';
// import 'package:provider/provider.dart';
//
// import 'main_screen.dart';
// import 'my_fridge.dart';
//
// class MainPage extends StatefulWidget {
//   int currentPageIndex;
//
//   MainPage({
//     super.key,
//     required this.currentPageIndex,
//   });
//
//   @override
//   State<MainPage> createState() => _MainPageState();
// }
//
// class _MainPageState extends State<MainPage> {
//   List<Widget> _pages = <Widget>[
//     ChangeNotifierProvider(
//       create: (_) => MainScreenViewModel(),
//       child: const MainScreen(),
//     ),
//     ChangeNotifierProvider(
//       create: (_) => MyFridgeViewModel(),
//       child: const MyFridge(),
//     ),
//     MyPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[widget.currentPageIndex],
//       bottomNavigationBar: NavigationBar(
//         onDestinationSelected: (int index) {
//           setState(() {
//             widget.currentPageIndex = index;
//           });
//         },
//         selectedIndex: widget.currentPageIndex,
//         destinations: <Widget>[
//           NavigationDestination(
//               selectedIcon: Icon(Icons.home, color: Colors.blueAccent),
//               icon: Icon(Icons.home_outlined, color: Colors.blueGrey),
//               label: '냉장고'),
//           NavigationDestination(
//               selectedIcon: Icon(Icons.kitchen, color: Colors.blueAccent),
//               icon: Icon(Icons.kitchen_outlined, color: Colors.blueGrey),
//               label: '나의 냉장고'),
//           NavigationDestination(
//               selectedIcon: Icon(Icons.person, color: Colors.blueAccent),
//               icon: Icon(Icons.person_outlined, color: Colors.blueGrey),
//               label: '마이페이지'),
//         ],
//       ),
//     );
//   }
// }
