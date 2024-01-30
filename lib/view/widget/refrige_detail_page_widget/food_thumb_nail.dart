import 'package:flutter/material.dart';
import 'package:leute/view/widget/custom_widgets/super_container.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

import '../../../data/models/foods_model.dart';
import '../../../styles/app_text_style.dart';
import '../my_food_detail_page_widget/food_detail_image_widget.dart';

class FoodThumbNail extends StatelessWidget {
  const FoodThumbNail(
      {super.key,
      required this.foodItem,
      required this.period,
      required this.extendPeriod,
      required this.isManager});

  final int period;
  final int extendPeriod;
  final FoodDetail foodItem;
  final bool isManager;

  @override
  Widget build(BuildContext context) {
    int passedDate = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(foodItem.registerDate))
        .inDays;
    int remainPeriod = period - passedDate;
    if (foodItem.isExtended == true) {
      remainPeriod += extendPeriod;
    }
    return GestureDetector(
      onTap: () {
        if (isManager) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FoodDetailImageWidget(
                itemImage: foodItem.foodImage,
              ),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 8),
        child: Column(
          children: [
            WidgetAnimator(
                incomingEffect:
                    WidgetTransitionEffects.incomingSlideInFromBottom(),
                atRestEffect: WidgetRestingEffects.swing(
                  numberOfPlays: 1,
                ),
                child: SuperContainer(
                  height: 70,
                  width: 80,
                  border: 50,
                  borderWidth: 5,
                  borderColor: (remainPeriod > 1)
                      ? const Color(0xFF9bc6bf)
                      : const Color(0xFFcb7d74),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      foodItem.foodImage,
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      Text(foodItem.userName, style: AppTextStyle.body12R()),
                      Text('남은날: $remainPeriod일', style: AppTextStyle.body12R())
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
