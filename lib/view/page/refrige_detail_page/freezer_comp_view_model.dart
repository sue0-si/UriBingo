import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../data/models/foods_model.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/foods_repository.dart';
import '../../../domain/user_data_repository.dart';
import '../../widget/refrige_detail_page_widget/food_thumb_nail_list.dart';

class FreezerCompViewModel extends ChangeNotifier {
  final RegisterdFoodsRepository foodsRepository;
  final UserDataRepository userDataRepository;

  FreezerCompViewModel({
    required this.foodsRepository,
    required this.userDataRepository,
  }) {
    fetchData();
  }

  RefrigeDetail? selectedRefrige;
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

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();

    try {
      List<UserModel> userData = await userDataRepository.getFirebaseUserData();
      final currentUser = userData.firstWhere(
          (user) => user.email == FirebaseAuth.instance.currentUser!.email);
      isManager = currentUser.manager;
      await getSameRefrigeFoods(
          selectedRefrige!.refrigeName, currentUser.groupName);

      // 관리자 여부 확인용 메서드
      for (int i = 1; i <= selectedRefrige!.freezerCompCount; i++) {
        final samePositionFoodList =
            foodsRepository.filterFoods(foodItems, true, i);
        fetchedList.add(FoodThumbNailList(
          samePositionFoodList: samePositionFoodList[2]
              .where((e) => fetchValidFoods(selectedRefrige!, e) >= 0)
              .toList(),
          selectedRefrige: selectedRefrige!,
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

  Future<List<FoodDetail>> getSameRefrigeFoods(
      String refrigeName, String validationCode) async {
    final allFoods = await foodsRepository.getFirebaseFoodsData();
    _foodItems = allFoods
        .where((e) => (e.vlaidationCode == validationCode &&
            e.refrigeName == refrigeName))
        .toList();
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
