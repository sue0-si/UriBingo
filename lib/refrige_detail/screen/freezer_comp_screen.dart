import 'package:flutter/material.dart';
import 'package:leute/refrige_detail/data/models/foods_model.dart';
import 'package:leute/refrige_detail/screen/freezer_comp_view_model.dart';

import '../data/mock_repository/foods_repository.dart';
import '../data/mock_repository/refrige_repository.dart';
import '../data/models/refrige_model.dart';
import '../widgets/food_thumb_nail_list.dart';
import 'package:provider/provider.dart';

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
    super.initState();
    initData();
    final foodInfos = freezerViewModel.foodItems;

    var refrigeItem = RegisterdRefrigeRepository()
        .getRefrigeDetail()[(widget.selectedRefrige.refrigeId) - 1];

    for (int i = 1; i <= refrigeItem.freezerCompCount; i++) {
      final samePositionFoodList =
          RegisterdFoodsRepository().filterFoods(foodInfos, true, i);
      sliverList.add(FoodThumbNailList(
        samePositionFoodList: samePositionFoodList[2],
        selectedRefrige: widget.selectedRefrige,
        selectedPosition: i,
      ));
    }
  }


  void initData() async {
    await freezerViewModel.getSameRefrigeFoods(widget.selectedRefrige.refrigeId);
    setState(() {
      freezerViewModel.foodItems;
    });
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
