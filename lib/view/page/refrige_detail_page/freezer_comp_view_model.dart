import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../../../data/models/foods_model.dart';
import '../../../data/models/user_model.dart';
import '../../../domain/foods_repository.dart';
import '../../../domain/user_data_repository.dart';
import '../../widget/refrige_detail_page_widget/food_thumb_nail_list.dart';
import 'freezer_comp_state.dart';

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

  FreezerCompState _state = const FreezerCompState();

  FreezerCompState get state => _state;

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

  // 같은 냉장고에 있는 음식정보 불러오기
  Future<List<FoodDetail>> getSameRefrigeFoods(
      String refrigeName, String groupName) async {
    final allFoods = await foodsRepository.getFirebaseFoodsData();
    _state = state.copyWith(
        foodItems: allFoods
            .where((e) => (e.groupName == groupName &&
                e.refrigeName == refrigeName))
            .toList());
    return _state.foodItems;
  }

  // 화면 진입 시 냉장고 안 음식 정보 가져오기
  Future<void> fetchData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      List<UserModel> userData = await userDataRepository.getFirebaseUserData();
      final currentUser = userData.firstWhere(
          (user) => user.email == FirebaseAuth.instance.currentUser!.email);
      _state = state.copyWith(isManager: currentUser.manager);
      await getSameRefrigeFoods(
          selectedRefrige!.refrigeName, currentUser.groupName);

      // 칸 위치(i) 마다 분리하여 리스트 생성 후 fetchedList에 저장
      for (int i = 1; i <= selectedRefrige!.freezerCompCount; i++) {
        final samePositionFoodList =
            foodsRepository.filterFoods(_state.foodItems, true, i);
        fetchedList.add(FoodThumbNailList(
          samePositionFoodList: samePositionFoodList[2]
              .where((e) => fetchValidFoods(selectedRefrige!, e) >= 0)
              .toList(),
          selectedRefrige: selectedRefrige!,
          selectedPosition: i,
          isFreezed: true,
          isManager: _state.isManager,
        ));
      }
      notifyListeners();
    } catch (error) {
      // 에러 처리
      print('Error fetching data: $error');
    } finally {
      _state = state.copyWith(isLoading: false);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // 폐기예정 음식 걸러내기 위한 남은기간 계산 메서드
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
