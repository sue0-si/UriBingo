import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/domain/foods_repository.dart';
import 'package:leute/domain/refrige_repository.dart';
import 'package:leute/view/page/main_my_fridge/my_fridge_state.dart';

class MyFridgeViewModel extends ChangeNotifier {
  final RegisterdFoodsRepository foodRepository;
  final RegisterdRefrigeRepository refrigeRepository;

  MyFridgeViewModel({
    required this.foodRepository,
    required this.refrigeRepository,
  }) {
    fetchMyFridgeData();
  }

  MyFridgeState _state = const MyFridgeState();

  MyFridgeState get state => _state;

  @override
  void dispose() {
    _state = state.copyWith(disposed: true);
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!state.disposed) {
      super.notifyListeners();
    }
  }

  Future<void> fetchMyFridgeData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final allFoods = await foodRepository.getFirebaseFoodsData();
    _state = state.copyWith(
      refrigeDetails: await refrigeRepository.getFirebaseRefrigesData(),
      myFoodDetails: foodRepository.getMyFoodDetail(
          allFoods, FirebaseAuth.instance.currentUser!.displayName!),
      isLoading: false,
    );
    notifyListeners();
  }
}
