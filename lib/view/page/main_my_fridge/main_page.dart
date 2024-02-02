import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/page/login_pages/my_page.dart';
import 'package:leute/view_model/main_screen_view_model.dart';
import 'package:leute/view_model/my_fridge_view_model.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import 'main_screen.dart';
import 'my_fridge.dart';

class MainPage extends StatefulWidget {
  int currentPageIndex;

  MainPage({
    super.key,
    required this.currentPageIndex,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = <Widget>[
    ChangeNotifierProvider(
      create: (_) => MainScreenViewModel(),
      child: const MainScreen(),
    ),
    ChangeNotifierProvider(
      create: (_) => MyFridgeViewModel(),
      child: const MyFridge(),
    ),
    MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.currentPageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        animationCurve: Curves.easeInOutExpo,
        index: widget.currentPageIndex,
        backgroundColor: Colors.white,
        color: const Color(0xFF9bc6bf),
        onTap: (int index) {
          setState(() {
            widget.currentPageIndex = index;
          });
        },
        items: <Widget>[
          Icon(Icons.kitchen_outlined,
              color: Colors.white, semanticLabel: '냉장고', size: 30),
          Text('My',style:AppTextStyle.header22(color: Colors.white),),
          Icon(UniconsLine.user,
              color: Colors.white, semanticLabel: '마이페이지', size: 30),
        ],
      ),
    );
  }
}
