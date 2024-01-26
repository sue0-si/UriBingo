import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';


class MyFoodDetailViewModel with ChangeNotifier {


  int calculateRemainPeriod(FoodDetail myFoodItem, RefrigeDetail ourRefrigeItem) {
    int passedDate =
        DateTime
            .now()
            .difference(
            DateTime.fromMillisecondsSinceEpoch(myFoodItem.registerDate))
            .inDays;
    int remainPeriod = ourRefrigeItem.period - passedDate;
    // if (myFoodItem.isExtended == true) {
    //   remainPeriod += ourRefirgeItem.period;
    // }
    return remainPeriod;
  }


  int extendPeriod(FoodDetail myFoodItem, RefrigeDetail ourRefirgeItem) {
    int extendedPeriod = 0;
    int remainPeriod = calculateRemainPeriod(myFoodItem, ourRefirgeItem);
    return extendedPeriod = remainPeriod + ourRefirgeItem.period;
  }


  bool checkOld(FoodDetail myFoodItem, RefrigeDetail ourRefirgeItem) {
    int remainPeriod = calculateRemainPeriod(myFoodItem, ourRefirgeItem);
    // if (myFoodItem.isExtended == true) {
    //   checkOld == false;
    // }
    return remainPeriod < 2;
  }

}
