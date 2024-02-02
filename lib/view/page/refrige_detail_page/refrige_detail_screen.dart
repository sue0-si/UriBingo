import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view/page/refrige_detail_page/freezer_comp_screen.dart';
import 'package:leute/view/page/refrige_detail_page/refrige_comp_screen.dart';
import 'package:provider/provider.dart';

import '../../../styles/app_text_style.dart';
import '../../../view_model/freezer_comp_view_model.dart';
import '../../../view_model/refrige_comp_view_model.dart';

class RefrigeDetailScreen extends StatefulWidget {
  final RefrigeDetail selectedRefrige;
  final int selectedIndex;

  const RefrigeDetailScreen(
      {Key? key, required this.selectedRefrige, required this.selectedIndex})
      : super(key: key);

  @override
  State<RefrigeDetailScreen> createState() => _RefrigeDetailScreenState();
}

class _RefrigeDetailScreenState extends State<RefrigeDetailScreen> {
  final PageController _pageController = PageController(initialPage: 1);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
            onPressed: () => context.go('/main_page', extra: 0)),
        title: SizedBox(
          height: 53,
          child: AnimatedButtonBar(
            radius: 32.0,
            padding: const EdgeInsets.all(3.0),
            backgroundColor: Colors.white,
            foregroundColor: const Color(0xFF9bc6bf),
            elevation: 24,
            borderColor: Colors.white,
            borderWidth: 3,
            innerVerticalPadding: 5,
            children: [
              ButtonBarEntry(
                  onTap: () => _pageController.animateToPage(
                      widget.selectedIndex == 1 ? widget.selectedIndex : 1,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: Text('냉장실',
                      style: AppTextStyle.body14R(color: Colors.black))),
              ButtonBarEntry(
                  onTap: () => _pageController.animateToPage(
                      widget.selectedIndex == 0 ? widget.selectedIndex : 0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut),
                  child: Text('냉동실',
                      style: AppTextStyle.body14R(color: Colors.black))),
            ],
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  context.go('/main_page', extra: 1);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color: Color(0xFF9bc6bf),
                  ),
                  width: 25,
                  height: 25,
                  child: const Center(
                    child: Text(
                      'My',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              )),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.vertical,
        children: [
          ChangeNotifierProvider(
            create: (context) => FreezerCompViewModel(widget.selectedRefrige),
            child: FreezerCompScreen(
              selectedRefrige: widget.selectedRefrige,
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => RefrigeCompViewModel(widget.selectedRefrige),
            child: RefrigeCompScreen(
              selectedRefrige: widget.selectedRefrige,
            ),
          ),
        ],
      ),
    );
  }
}
