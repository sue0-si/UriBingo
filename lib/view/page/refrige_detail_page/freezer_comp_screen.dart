import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view_model/freezer_comp_view_model.dart';
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              context.go('/details', extra: widget.selectedRefrige),
        ),
        title: Text('냉동실', style: AppTextStyle.body14R()),
      ),
      body: (viewModel.isLoading)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: AnimationList(
                duration: 2000,
                reBounceDepth: 5.0,
                children: viewModel.fetchedList,
              ),
            ),
    );
  }
}
