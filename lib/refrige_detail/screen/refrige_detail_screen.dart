import 'package:flutter/material.dart';

import 'freezer_comp_screen.dart';
import 'refrige_comp_screen.dart';

class RefrigeDetailScreen extends StatefulWidget {
  final int refrigeNum;

  const RefrigeDetailScreen({Key? key, required this.refrigeNum}) : super(key: key);

  @override
  State<RefrigeDetailScreen> createState() => _RefrigeDetailScreenState();
}


class _RefrigeDetailScreenState extends State<RefrigeDetailScreen> {
  final PageController _pageController = PageController(initialPage: 1);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        physics: const ClampingScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.vertical,
        children: [
          FreezerCompScreen(refrigeNum: widget.refrigeNum),
          RefrigeCompScreen(refrigeNum: widget.refrigeNum),
        ],
      ),
    );
  }
}