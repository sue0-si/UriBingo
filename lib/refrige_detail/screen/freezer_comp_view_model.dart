import 'package:flutter/foundation.dart';

import '../data/mock_repository/foods_repository.dart';
import '../data/models/foods_model.dart';

class FreezerCompViewModel extends ChangeNotifier {
  final _repository = RegisterdFoodsRepository();

  List<FoodDetail> _foodItems = [];

  List<FoodDetail> get foodItems => _foodItems;

  Future<List<FoodDetail>> getSameRefrigeFoods(int refrigeIndex) async {
    final allFoods = await _repository.getFirebaseFoodsData();
    List<FoodDetail> getFoodDetail(int num) {
      return allFoods.where((e) => e.refrigeId == num).toList();
    }

    _foodItems = getFoodDetail(refrigeIndex);
    return _foodItems;
  }

  notifyListeners();
}
