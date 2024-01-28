import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../styles/app_text_style.dart';
import '../../../view_model/refrige_comp_view_model.dart';
import '../../widget/custom_widgets/super_loading_bar.dart';

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
        title: Text('냉장실', style: AppTextStyle.body14R(
          color: const Color(0xFF254e7a),
        ),),
        actions: [
          GestureDetector(
            onTap: (){context.go('/', extra: 1);},
            child: const Icon(UniconsLine.apps,
                color: Color(0xFF254e7a), semanticLabel: '마이냉장고', size: 30),
          ),
        ],
      ),
      body: (viewModel.isLoading)
          ? Center(
              child: SuperLoadingBar(
                colors: const [Color(0xFF254e7a)],
                strokeWidth: 4,
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
