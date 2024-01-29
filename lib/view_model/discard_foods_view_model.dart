import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/repository/foods_repository.dart';
import 'package:leute/data/repository/refrige_repository.dart';

class DiscardFoodsViewModel extends ChangeNotifier {
  final foodRepository = RegisterdFoodsRepository();
  final refrigeRepository = RegisterdRefrigeRepository();
  List<FoodDetail>  discardFoodsDetails = [];
  List<RefrigeDetail> refrigeDetails = [];
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  DiscardFoodsViewModel() {
    fetchDiscardFoodsData();
  }

  Future<void> fetchDiscardFoodsData() async {
    final allFoods = await foodRepository.getFirebaseFoodsData();
    refrigeDetails = await refrigeRepository.getFirebaseRefrigesData();
    for (var refrigeDetail in refrigeDetails){
      discardFoodsDetails += allFoods.where((e) => fetchValidFoods(refrigeDetail, e) <= 0).toList();
    }
    // refrigeDetails;
    notifyListeners();
  }

  int fetchValidFoods(RefrigeDetail selectedRefrige, FoodDetail foodItem){
    int passedDate = DateTime.now()
        .difference(DateTime.fromMillisecondsSinceEpoch(foodItem.registerDate))
        .inDays;
    int remainPeriod = selectedRefrige.period - passedDate;
    if (foodItem.isExtended == true) {
      remainPeriod += selectedRefrige.extentionPeriod;
    }
    return remainPeriod;
  }


}
