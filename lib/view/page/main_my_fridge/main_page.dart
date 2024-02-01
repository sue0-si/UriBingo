import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  var messageString = "";

  void getMyDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();

    print("내 디바이스 토큰: $token");
  }



  @override
  void initState() {
    getMyDeviceToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;

      if (notification != null) {
        FlutterLocalNotificationsPlugin().show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'high_importance_notification',
              importance: Importance.max,
            ),
          ),
        );
        setState(() {
          messageString = message.notification!.body!;
          print("Foreground 메시지 수신: $messageString");
        });
      }
    });    super.initState();
  }



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
        items: const <Widget>[
          Icon(UniconsLine.home,
              color: Colors.white, semanticLabel: '냉장고', size: 30),
          Icon(Icons.kitchen_outlined,
              color: Colors.white, semanticLabel: '마이냉장고', size: 30),
          Icon(UniconsLine.user,
              color: Colors.white, semanticLabel: '마이페이지', size: 30),
        ],
      ),
    );
  }
}
