import 'package:flutter/foundation.dart';

import '../data/models/foods_model.dart';
import '../data/repository/foods_repository.dart';

class FreezerCompViewModel extends ChangeNotifier {
  final _repository = RegisterdFoodsRepository();

  List<FoodDetail> _foodItems = [];

  List<FoodDetail> get foodItems => _foodItems;

  Future<List<FoodDetail>> getSameRefrigeFoods(String refrigeName) async {
    final allFoods = await _repository.getFirebaseFoodsData();
    _foodItems = allFoods.where((e) => e.refrigeName == refrigeName).toList();
    return _foodItems;
  }
  notifyListeners();
}
