import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../domain/foods_repository.dart';
import '../../../domain/refrige_repository.dart';
import 'discard_foods_state.dart';

class DiscardFoodsViewModel extends ChangeNotifier {
  final RegisterdFoodsRepository foodRepository;
  final RegisterdRefrigeRepository refrigeRepository;

  DiscardFoodsViewModel({
    required this.foodRepository,
    required this.refrigeRepository,
  }) {
    fetchDiscardFoodsData();
  }

  DiscardFoodsState _state = const DiscardFoodsState();
  DiscardFoodsState get state => _state;

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

  Future<void> fetchDiscardFoodsData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final allFoods = await foodRepository.getFirebaseFoodsData();
    _state = state.copyWith(refrigeDetails: await refrigeRepository.getFirebaseRefrigesData());
    notifyListeners();

    for (var refrigeDetail in _state.refrigeDetails) {
      final sameRefrigeFoods =
          foodRepository.getFoodDetail(allFoods, refrigeDetail.refrigeName, refrigeDetail.groupName);
      _state = state.copyWith(discardFoodsDetails: _state.discardFoodsDetails + sameRefrigeFoods
          .where((e) => fetchValidFoods(refrigeDetail, e) < 0)
          .toList(),
      isLoading: false);

    }
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
