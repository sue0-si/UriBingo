import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';

class MyFoodDetailViewModel with ChangeNotifier {

//남은기간 계산, remainPeriod를 연장한 기간으로 저장 (초기화 되지 않도록 처리)
  int calculateRemainPeriod(FoodDetail myFoodItem,
      RefrigeDetail ourRefrigeItem) {
    int passedDate = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(myFoodItem.registerDate)).inDays;
    int remainPeriod = ourRefrigeItem.period - passedDate;
    if (myFoodItem.isExtended == true) {
      remainPeriod += ourRefrigeItem.period;
    }
    return remainPeriod;
  }


//연장기간 출력
  int extendPeriod(FoodDetail myFoodItem, RefrigeDetail ourRefirgeItem) {
    int remainPeriod = calculateRemainPeriod(myFoodItem, ourRefirgeItem);
    return remainPeriod + ourRefirgeItem.period;
  }

//2일 미만인지 여부 & isExtended 체크
  bool checkOld(FoodDetail myFoodItem, RefrigeDetail ourRefirgeItem) {
    int remainPeriod = calculateRemainPeriod(myFoodItem, ourRefirgeItem);
    if (remainPeriod >= 2 || myFoodItem.isExtended == true) {
      return false;
    }
    return remainPeriod < 2;
  }

  //isExtended값 변경
  Future<void> updateFirestore(FoodDetail myFoodItem) async {
    await FirebaseFirestore.instance
        .collection('foodDetails')
        .doc(myFoodItem.registerDate
        .toString() + myFoodItem.userId)
        .update({"isExtended": true});
  }

  //firebase, firestore 삭제
  Future<void> deleteFoodAndStorage(FoodDetail myFoodItem,RefrigeDetail ourRefirgeItem ) async {
    await Future.wait([FirebaseFirestore.instance
        .collection('foodDetails')
        .doc(myFoodItem.registerDate
        .toString() + myFoodItem.userId)
        .delete(),
    FirebaseStorage.instance
        .ref("images/${myFoodItem.registerDate}.jpg")
        .delete(),
    ]);
  }
  }



