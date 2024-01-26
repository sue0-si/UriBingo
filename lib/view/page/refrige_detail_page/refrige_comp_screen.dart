import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:provider/provider.dart';

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
          onPressed: () => context.go('/', extra: 0),
        ),
        title: Text('냉장실'),
      ),
      body: Consumer<RefrigeCompViewModel>(
        builder: (context, refrigeViewModel, child) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            slivers: refrigeViewModel.fetchedList,
          );
        },
      ),
    );
  }
}
