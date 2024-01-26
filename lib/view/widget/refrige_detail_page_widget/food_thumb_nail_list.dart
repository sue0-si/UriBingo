import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../data/models/foods_model.dart';
import 'food_thumb_nail.dart';

class FoodThumbNailList extends StatelessWidget {
  const FoodThumbNailList(
      {super.key,
      required this.samePositionFoodList,
      required this.selectedRefrige,
      required this.selectedPosition,
        required this.isFreezed});

  final RefrigeDetail selectedRefrige;
  final int selectedPosition;
  final List<FoodDetail> samePositionFoodList;
  final bool isFreezed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // image: DecorationImage(opacity: 0.5,
        //   image: AssetImage('assets/images/shelf.png'),
        //   fit: BoxFit.fill
        // ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: samePositionFoodList.length,
                itemBuilder: (context, index) {
                  final foodItem = samePositionFoodList[index];
                  return FoodThumbNail(
                    foodItem: foodItem,
                    period: selectedRefrige.period,
                    extendPeriod: selectedRefrige.extentionPeriod,
                  );
                }),
          ),
          Expanded(
              child: IconButton(
                  onPressed: () => context.go('/addMyFood', extra: [
                        selectedRefrige,
                        selectedPosition,
                        samePositionFoodList,
                        isFreezed
                      ]),
                  icon: const Icon(Icons.add)))
        ],
      ),
    );
  }
}
