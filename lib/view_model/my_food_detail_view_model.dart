import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';

class MyFoodDetailViewModel with ChangeNotifier {

//남은기간 계산: 관리자가 정한 기간 - 지난날 (등록일과 현재 날짜 사이의 일수)
//isExtended true이면 remainPeriod를 연장한 기간으로 저장 (초기화 되지 않도록 처리)
  int calculateRemainPeriod(FoodDetail myFoodItem,
      RefrigeDetail ourRefrigeItem) {
    int passedDate =
        DateTime
            .now()
            .difference(
            DateTime.fromMillisecondsSinceEpoch(myFoodItem.registerDate))
            .inDays;
    int remainPeriod = ourRefrigeItem.period - passedDate;
    if (myFoodItem.isExtended == true) {
      remainPeriod += ourRefrigeItem.period;
    }
    return remainPeriod;
  }


//연장기간 출력 (남은기간 + 관리자가 설정한 기간)
  int extendPeriod(FoodDetail myFoodItem, RefrigeDetail ourRefirgeItem) {
    int remainPeriod = calculateRemainPeriod(myFoodItem, ourRefirgeItem);
    return remainPeriod + ourRefirgeItem.extentionPeriod;
  }

//2일 미만: true 2일 이상이거나 isExtended가 true : false
  bool checkOld(FoodDetail myFoodItem, RefrigeDetail ourRefirgeItem) {
    int remainPeriod = calculateRemainPeriod(myFoodItem, ourRefirgeItem);
    if (remainPeriod >= 2 || myFoodItem.isExtended == true) {
      return false;
    }
    return remainPeriod < 2;
  }

}
