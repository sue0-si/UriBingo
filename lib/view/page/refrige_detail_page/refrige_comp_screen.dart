import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view/page/refrige_detail_page/refrige_comp_view_model.dart';

import '../../../data/mock_repository/foods_repository.dart';
import '../../widget/refrige_detail_page_widget/food_thumb_nail_list.dart';

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
  final refrigeViewModel = RefrigeCompViewModel();
  List<Widget> sliverList = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    await refrigeViewModel
        .getSameRefrigeFoods(widget.selectedRefrige.refrigeId);
    setState(() {
      refrigeViewModel.foodItems;
    });
    for (int i = 1; i <= widget.selectedRefrige.refrigeCompCount; i++) {
      final samePositionFoodList = RegisterdFoodsRepository()
          .filterFoods(refrigeViewModel.foodItems, false, i);
      print(refrigeViewModel.foodItems.length);
      sliverList.add(FoodThumbNailList(
        samePositionFoodList: samePositionFoodList[2],
        selectedRefrige: widget.selectedRefrige,
        selectedPosition: i,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text('냉장실'),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: sliverList,
      ),
    );
  }
}
