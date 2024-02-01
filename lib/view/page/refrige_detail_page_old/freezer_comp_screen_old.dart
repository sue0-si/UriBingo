import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view_model/freezer_comp_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/models/refrige_model.dart';
import '../../../styles/app_text_style.dart';

class FreezerCompScreen extends StatefulWidget {
  final RefrigeDetail selectedRefrige;

  const FreezerCompScreen({
    Key? key,
    required this.selectedRefrige,
  }) : super(key: key);

  @override
  State<FreezerCompScreen> createState() => _FreezerCompScreenState();
}

class _FreezerCompScreenState extends State<FreezerCompScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FreezerCompViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => context.go('/main_page', extra: 0)),
        title: Text('냉동실', style: AppTextStyle.body14R(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                context.go('/main_page', extra: 1);
              },
              child: const Icon(Icons.kitchen_outlined,
                  color: Colors.white, semanticLabel: '마이냉장고', size: 30),
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: (viewModel.isLoading)
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: Colors.white,
                size: 50,
              ),
            )
          : Center(
              child: AnimationList(
                physics: const BouncingScrollPhysics(
                    decelerationRate: ScrollDecelerationRate.fast),
                duration: 2000,
                reBounceDepth: 5.0,
                children: viewModel.fetchedList,
              ),
            ),
    );
  }
}
