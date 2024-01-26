import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/details', extra: widget.selectedRefrige),
        ),
        title: Text('냉장실', style: AppTextStyle.body14R()),
      ),
      body: Consumer<RefrigeCompViewModel>(
        builder: (context, refrigeViewModel, child) {
          return Center(
              child: AnimationList(
                physics: NeverScrollableScrollPhysics(),
                children: refrigeViewModel.fetchedList,
                duration: 2000,
                reBounceDepth:5.0,
              ));
        },
      ),
    );
  }
}
