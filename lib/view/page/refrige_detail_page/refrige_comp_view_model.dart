import 'package:flutter/foundation.dart';

import '../../../data/mock_repository/foods_repository.dart';
import '../../../data/models/foods_model.dart';

class RefrigeCompViewModel extends ChangeNotifier {
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
