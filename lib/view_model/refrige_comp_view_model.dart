import 'package:flutter/material.dart';

import '../data/models/foods_model.dart';
import '../data/models/refrige_model.dart';
import '../data/repository/foods_repository.dart';
import '../view/widget/refrige_detail_page_widget/food_thumb_nail_list.dart';

class RefrigeCompViewModel extends ChangeNotifier {
  final RefrigeDetail selectedRefrige;
  final _repository = RegisterdFoodsRepository();

  List<FoodDetail> _foodItems = [];

  List<FoodDetail> get foodItems => _foodItems;

  List<Widget> fetchedList = [];
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

  RefrigeCompViewModel(this.selectedRefrige) {
    fetchData();
  }

  Future<void> fetchData() async {
    await getSameRefrigeFoods(selectedRefrige.refrigeName);
    for (int i = 1; i <= selectedRefrige.refrigeCompCount; i++) {
      final samePositionFoodList =
          RegisterdFoodsRepository().filterFoods(foodItems, false, i);
      fetchedList.add(FoodThumbNailList(
        samePositionFoodList: samePositionFoodList[2],
        selectedRefrige: selectedRefrige,
        selectedPosition: i,
        isFreezed: false,
      ));
    }
    notifyListeners();
  }

  Future<List<FoodDetail>> getSameRefrigeFoods(String refrigeName) async {
    final allFoods = await _repository.getFirebaseFoodsData();
    _foodItems = allFoods.where((e) => e.refrigeName == refrigeName).toList();
    return _foodItems;
  }

}
