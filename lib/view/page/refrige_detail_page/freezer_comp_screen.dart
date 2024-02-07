import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:leute/view/page/refrige_detail_page/freezer_comp_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/models/refrige_model.dart';

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
    viewModel.selectedRefrige = widget.selectedRefrige;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        body: (viewModel.isLoading)
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xFF9bc6bf),
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
      ),
    );
  }
}
