// import 'dart:math';
//
// import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:leute/view/page/login_pages/my_page.dart';
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
//   late final NotchBottomBarController _controller;
//   int maxCount = 3;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = NotchBottomBarController(index: widget.currentPageIndex);
//   }
//
//   final List<Widget> _pages = <Widget>[
//     const MainScreen(),
//     const MyFridge(),
//     const MyPage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _pages[widget.currentPageIndex],
//       extendBody: true,
//       bottomNavigationBar: (_pages.length <= maxCount)
//           ? AnimatedNotchBottomBar(
//         /// Provide NotchBottomBarController
//         notchBottomBarController: _controller,
//         color: Colors.white,
//         showLabel: false,
//         shadowElevation: 5,
//         kBottomRadius: 28.0,
//         notchShader: const SweepGradient(
//           startAngle: 0,
//           endAngle: pi / 2,
//           colors: [Colors.red, Colors.green, ],
//           tileMode: TileMode.mirror,
//         ).createShader(Rect.fromCircle(center: Offset.zero, radius: 8.0)),
//         notchColor: Colors.black87,
//
//         /// restart app if you change removeMargins
//         removeMargins: false,
//         bottomBarWidth: 500,
//         durationInMilliSeconds: 300,
//         bottomBarItems: const [
//           BottomBarItem(
//               inActiveItem:
//               Icon(Icons.home_outlined, color: Colors.blueGrey),
//               activeItem: Icon(
//                 Icons.home,
//                 color: Colors.blueAccent,
//               ),
//               itemLabel: '냉장고'),
//           BottomBarItem(
//             inActiveItem: Icon(
//               Icons.kitchen_outlined,
//               color: Colors.blueGrey,
//             ),
//             activeItem: Icon(
//               Icons.kitchen,
//               color: Colors.blueAccent,
//             ),
//             itemLabel: '나의 냉장고',
//           ),
//           BottomBarItem(
//             inActiveItem: Icon(
//               Icons.person_outlined,
//               color: Colors.blueGrey,
//             ),
//             activeItem: Icon(
//               Icons.person,
//               color: Colors.blueAccent,
//             ),
//             itemLabel: '마이페이지',
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             widget.currentPageIndex = index;
//           });
//
//         },
//         kIconSize: 24.0,
//       )
//           : null,
//     );
//   }
// }
