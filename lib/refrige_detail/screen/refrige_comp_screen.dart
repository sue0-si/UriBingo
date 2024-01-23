import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/refrige_detail/data/models/refrige_model.dart';

import '../data/mock_repository/foods_repository.dart';
import '../data/mock_repository/refrige_repository.dart';
import '../widgets/food_thumb_nail_list.dart';

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
  List<Widget> sliverList = [];

  @override
  void initState() {
    super.initState();
    final foodInfos = RegisterdFoodsRepository()
        .getFoodDetail(widget.selectedRefrige.refrigeId);
    var refrigeItem = RegisterdRefrigeRepository()
        .getRefrigeDetail()[(widget.selectedRefrige.refrigeId) - 1];

    for (int i = 1; i <= refrigeItem.refrigeCompCount; i++) {
      final samePositionFoodList =
          RegisterdFoodsRepository().filterFoods(foodInfos, false, i);
      sliverList.add(
        FoodThumbNailList(
            selectedRefrige: widget.selectedRefrige,
            samePositionFoodList: samePositionFoodList[2],
            selectedPosition: i),
      );
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
