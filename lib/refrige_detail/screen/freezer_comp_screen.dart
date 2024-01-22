import 'package:flutter/material.dart';

import '../data/mock_repository/foods_repository.dart';
import '../data/mock_repository/refrige_repository.dart';
import '../widgets/food_thumb_nail_list.dart';

class FreezerCompScreen extends StatefulWidget {
  final int refrigeNum;

  const FreezerCompScreen({
    Key? key,
    required this.refrigeNum,
  }) : super(key: key);

  @override
  State<FreezerCompScreen> createState() => _FreezerCompScreenState();
}

class _FreezerCompScreenState extends State<FreezerCompScreen> {
  List<Widget> sliverList = [];

  @override
  void initState() {
    super.initState();
    final foodInfos =
        RegisterdFoodsRepository().getFoodDetail(widget.refrigeNum);
    var refrigeItem =
        RegisterdRefrigeRepository().getRefrigeDetail()[widget.refrigeNum-1];

    for (int i = 0; i < refrigeItem.freezerCompCount; i++) {
      final samePositionFoodList =
          RegisterdFoodsRepository().filterFoods(foodInfos, true, i + 1);
      sliverList
          .add(FoodThumbNailList(samePositionFoodList: samePositionFoodList));
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
