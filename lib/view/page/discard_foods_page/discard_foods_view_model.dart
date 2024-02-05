import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../domain/foods_repository.dart';
import '../../../domain/refrige_repository.dart';

class DiscardFoodsViewModel extends ChangeNotifier {
  final RegisterdFoodsRepository foodRepository;
  final RegisterdRefrigeRepository refrigeRepository;

  DiscardFoodsViewModel({
    required this.foodRepository,
    required this.refrigeRepository,
  }) {
    fetchDiscardFoodsData();
  }

  List<FoodDetail> discardFoodsDetails = [];
  List<RefrigeDetail> refrigeDetails = [];
  bool _disposed = false;
  bool isLoading = false;

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

  Future<void> fetchDiscardFoodsData() async {
    isLoading = true;
    notifyListeners();

    final allFoods = await foodRepository.getFirebaseFoodsData();
    refrigeDetails = await refrigeRepository.getFirebaseRefrigesData();

    for (var refrigeDetail in refrigeDetails) {
      final sameRefrigeFoods =
          foodRepository.getFoodDetail(allFoods, refrigeDetail.refrigeName);
      discardFoodsDetails += sameRefrigeFoods
          .where((e) => fetchValidFoods(refrigeDetail, e) < 0)
          .toList();
    }
    // refrigeDetails;
    isLoading = false;
    notifyListeners();
  }

  int fetchValidFoods(RefrigeDetail selectedRefrige, FoodDetail foodItem) {
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
