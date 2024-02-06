import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view/page/refrige_detail_page/refrige_comp_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class RefrigeCompScreen extends StatefulWidget {
  final RefrigeDetail selectedRefrige;

  const RefrigeCompScreen({
    Key? key,
    required this.selectedRefrige,
  }) : super(key: key);

  @override
  State<RefrigeCompScreen> createState() => _RefrigeCompScreenState();
}

class _RefrigeCompScreenState extends State<RefrigeCompScreen> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RefrigeCompViewModel>();
    viewModel.selectedRefrige = widget.selectedRefrige;
    final state = viewModel.state;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Scaffold(
        body: (state.isLoading)
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
