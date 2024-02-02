import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/repository/user_data_repository.dart';

import '../data/models/foods_model.dart';
import '../data/models/user_model.dart';
import '../data/repository/foods_repository.dart';
import '../view/widget/refrige_detail_page_widget/food_thumb_nail_list.dart';

class FreezerCompViewModel extends ChangeNotifier {
  final RefrigeDetail selectedRefrige;
  final _repository = RegisterdFoodsRepository();
  final UserDataRepository userDataRepository = UserDataRepository();

  List<FoodDetail> _foodItems = [];

  List<FoodDetail> get foodItems => _foodItems;

  List<Widget> fetchedList = [];
  bool isLoading = false;
  bool isManager = false;
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

  FreezerCompViewModel(this.selectedRefrige) {
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();

    try {
      await getSameRefrigeFoods(selectedRefrige.refrigeName, foodItems[0].groupName);

      // 관리자 여부 확인용 메서드
      List<UserModel> userData = await userDataRepository.getFirebaseUserData();
      isManager = userData
          .firstWhere(
              (user) => user.email == FirebaseAuth.instance.currentUser!.email)
          .manager;
      for (int i = 1; i <= selectedRefrige.freezerCompCount; i++) {
        final samePositionFoodList =
            _repository.filterFoods(foodItems, true, i);
        fetchedList.add(FoodThumbNailList(
          samePositionFoodList: samePositionFoodList[2]
              .where((e) => fetchValidFoods(selectedRefrige, e) >= 0)
              .toList(),
          selectedRefrige: selectedRefrige,
          selectedPosition: i,
          isFreezed: true,
          isManager: isManager,
        ));
      }
    } catch (error) {
      // 에러 처리
      print('Error fetching data: $error');
    } finally {
      isLoading = false;
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future<List<FoodDetail>> getSameRefrigeFoods(String refrigeName, String groupName) async {
    final allFoods = await _repository.getFirebaseFoodsData();
    _foodItems = allFoods.where((e) => (e.refrigeName == refrigeName && e.groupName == groupName)).toList();
    return _foodItems;
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
