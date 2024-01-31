import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../styles/app_text_style.dart';

class RefrigeDetailScreen extends StatefulWidget {
  final RefrigeDetail selectedRefrige;

  const RefrigeDetailScreen({Key? key, required this.selectedRefrige})
      : super(key: key);

  @override
  State<RefrigeDetailScreen> createState() => _RefrigeDetailScreenState();
}

class _RefrigeDetailScreenState extends State<RefrigeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/main_page', extra: 0),
        ),
        title: Text(widget.selectedRefrige.refrigeName,
            style: AppTextStyle.body20R()),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedWidget(
            delayDuration: const Duration(milliseconds: 1000),
            // Not required
            animationDuration: const Duration(seconds: 1),
            // Not required
            animation: DelayedAnimations.SLIDE_FROM_BOTTOM,
            // Not required
            child: GestureDetector(
              onTap: () =>
                  context.go('/freezerDetail', extra: widget.selectedRefrige),
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                width: 220.w,
                height: 106.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/freezer_comp.png'),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 3),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child: Center(
                  child: Text('냉동실', style: AppTextStyle.body14R()),
                ),
              ),
            ),
          ),
          DelayedWidget(
            delayDuration: const Duration(milliseconds: 100),
            // Not required
            animationDuration: const Duration(seconds: 1),
            // Not required
            animation: DelayedAnimations.SLIDE_FROM_RIGHT,
            // Not required
            child: GestureDetector(
              onTap: () =>
                  context.go('/refrigeDetail', extra: widget.selectedRefrige),
              child: Container(
                width: 220.w,
                height: 220.h,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                      image: AssetImage('assets/images/refrige_comp.png'),
                      fit: BoxFit.cover),
                  color: Colors.white,
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 3),
                      blurRadius: 2.0,
                    ),
                  ],
                ),
                child:
                    Center(child: Text('냉장실', style: AppTextStyle.body14R())),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
