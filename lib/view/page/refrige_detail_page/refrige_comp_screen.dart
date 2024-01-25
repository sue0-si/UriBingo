import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../data/repository/foods_repository.dart';
import '../../../view_model/refrige_comp_view_model.dart';
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
        .getSameRefrigeFoods(widget.selectedRefrige.refrigeName);
    setState(() {
      refrigeViewModel.foodItems;
    });
    for (int i = 1; i <= widget.selectedRefrige.refrigeCompCount; i++) {
      final samePositionFoodList = RegisterdFoodsRepository()
          .filterFoods(refrigeViewModel.foodItems, false, i);
      sliverList.add(FoodThumbNailList(
        samePositionFoodList: samePositionFoodList[2],
        selectedRefrige: widget.selectedRefrige,
        selectedPosition: i,
        isFreezed: false,
      ));
    }
  }

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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: sliverList,
      ),
    );
  }
}
