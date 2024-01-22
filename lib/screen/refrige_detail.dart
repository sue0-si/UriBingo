import 'package:flutter/material.dart';
import 'package:leute/screen/refrige_comp_screen.dart';

import 'freezer_comp_screen.dart';

class RefrigeDetail extends StatefulWidget {
  final int refrigeNum;

  const RefrigeDetail({Key? key, required this.refrigeNum}) : super(key: key);

  @override
  State<RefrigeDetail> createState() => _RefrigeDetailState();
}


class _RefrigeDetailState extends State<RefrigeDetail> {
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