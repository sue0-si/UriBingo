import 'package:flutter/material.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../data/models/foods_model.dart';
import '../../../styles/app_text_style.dart';

class FoodThumbNail extends StatelessWidget {
  const FoodThumbNail(
      {super.key,
      required this.foodItem,
      required this.period,
      required this.extendPeriod});

  final int period;
  final int extendPeriod;
  final FoodDetail foodItem;

  @override
  Widget build(BuildContext context) {
    int passedDate = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(foodItem.registerDate))
        .inDays;
    int remainPeriod = period - passedDate;
    if (foodItem.isExtended == true) {
      remainPeriod += extendPeriod;
    }
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 8),
      child: Column(
        children: [
          WidgetAnimator(
            incomingEffect: WidgetTransitionEffects.incomingSlideInFromBottom(),
            atRestEffect: WidgetRestingEffects.swing(
              numberOfPlays: 2,
            ),
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  foodItem.foodImage,
                  height: 70,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Text('주인: ${foodItem.userName}',
                      style: AppTextStyle.body12R()),
                  Text('남은날: $remainPeriod 일', style: AppTextStyle.body12R())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
