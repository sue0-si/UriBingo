import 'package:flutter/material.dart';
import 'package:leute/view/page/refrige_detail_page/freezer_comp_view_model.dart';

import '../../../data/mock_repository/foods_repository.dart';
import '../../../data/models/refrige_model.dart';
import '../../widget/refrige_detail_page_widget/food_thumb_nail_list.dart';

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
  final freezerViewModel = FreezerCompViewModel();
  List<Widget> sliverList = [];

  @override
  void initState() {
    initData();

    super.initState();
  }

  void initData() async {
    await freezerViewModel
        .getSameRefrigeFoods(widget.selectedRefrige.refrigeId);
    setState(() {
      freezerViewModel.foodItems;
    });

    for (int i = 1; i <= widget.selectedRefrige.freezerCompCount; i++) {
      final samePositionFoodList = RegisterdFoodsRepository()
          .filterFoods(freezerViewModel.foodItems, true, i);
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
        title: Text('냉동실'),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: sliverList,
      ),
    );
  }
}
