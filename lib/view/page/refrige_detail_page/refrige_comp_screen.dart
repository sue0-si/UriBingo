import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../../styles/app_text_style.dart';
import '../../../view_model/refrige_comp_view_model.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.go('/details', extra: widget.selectedRefrige),
        ),
        title: Text('냉장실', style: AppTextStyle.body14R()),
      ),
      body: (viewModel.isLoading)
          ? const Center(
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotateMultiple,
                colors: [Color(0xFF254e7a)],
                strokeWidth: 4,
              ),
            )
          : Center(
              child: AnimationList(
                physics: const NeverScrollableScrollPhysics(),
                duration: 2000,
                reBounceDepth: 5.0,
                children: viewModel.fetchedList,
              ),
            ),
    );
  }
}
