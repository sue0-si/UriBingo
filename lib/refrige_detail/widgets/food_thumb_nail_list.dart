import 'package:flutter/material.dart';

import '../data/foods_model/foods_model.dart';
import 'food_thumb_nail.dart';

class FoodThumbNailList extends StatelessWidget {
  const FoodThumbNailList({super.key, required this.samePositionFoodList});

  final List<FoodDetail> samePositionFoodList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    );
                  }),
            ),
            Expanded(
                child:
                    IconButton(onPressed: () {}, icon: const Icon(Icons.add)))
          ],
        ),
      ),
    );
  }
}
