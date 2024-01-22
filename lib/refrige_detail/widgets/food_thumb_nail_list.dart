import 'package:flutter/material.dart';

import '../data/foods_model/foods_model.dart';
import 'food_thumb_nail.dart';

class FoodThumbNailList extends StatelessWidget {
  const FoodThumbNailList({super.key, required this.samePositionFoodList});

  final List<FoodDetail> samePositionFoodList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
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
