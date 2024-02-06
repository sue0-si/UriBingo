import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/repository/foods_repository_impl.dart';
import 'package:leute/data/repository/refrige_repository_impl.dart';
import 'package:leute/view/page/main_my_fridge/my_fridge_state.dart';

class MyFridgeViewModel extends ChangeNotifier {
  final foodRepository = RegisterdFoodsRepositoryImpl();
  final refrigeRepository = RegisterdRefrigeRepositoryImpl();

  MyFridgeState _state = MyFridgeState();

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

  MyFridgeViewModel() {
    fetchMyFridgeData();
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
