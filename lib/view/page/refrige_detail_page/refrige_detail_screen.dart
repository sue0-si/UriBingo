import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view/page/refrige_detail_page/freezer_comp_view_model.dart';
import 'package:leute/view/page/refrige_detail_page/refrige_comp_view_model.dart';
import 'package:provider/provider.dart';

import 'freezer_comp_screen.dart';
import 'refrige_comp_screen.dart';

class RefrigeDetailScreen extends StatefulWidget {
  final RefrigeDetail selectedRefrige;

  const RefrigeDetailScreen({Key? key, required this.selectedRefrige})
      : super(key: key);

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
          ChangeNotifierProvider(
            create: (context) => FreezerCompViewModel(),
            child: FreezerCompScreen(
              selectedRefrige: widget.selectedRefrige,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => RefrigeCompViewModel(),
            child: RefrigeCompScreen(
              selectedRefrige: widget.selectedRefrige,
            ),
          ),
        ],
      ),
    );
  }
}
