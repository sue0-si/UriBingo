import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/domain/foods_repository.dart';
import 'package:leute/domain/refrige_repository.dart';
import 'package:leute/domain/user_data_repository.dart';
import 'package:leute/view/page/main_my_fridge/my_fridge_state.dart';

import '../../../data/models/user_model.dart';

class MyFridgeViewModel extends ChangeNotifier {
  final UserDataRepository userDataRepository;
  final RegisterdFoodsRepository foodRepository;
  final RegisterdRefrigeRepository refrigeRepository;

  MyFridgeViewModel({
    required this.userDataRepository,
    required this.foodRepository,
    required this.refrigeRepository,
  }) {
    fetchMyFridgeData();
  }

  MyFridgeState _state = const MyFridgeState();

  MyFridgeState get state => _state;

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

  Future<void> fetchMyFridgeData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    final allFoods = await foodRepository.getFirebaseFoodsData();
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    UserModel currentUser = userData.firstWhere(
            (user) => user.email == FirebaseAuth.instance.currentUser!.email);
    _state = state.copyWith(
      refrigeDetails: await refrigeRepository.getFirebaseRefrigesData(),
      myFoodDetails: foodRepository.getMyFoodDetail(
          allFoods, currentUser.name, currentUser.validationCode),
      isLoading: false,
    );
    notifyListeners();
  }
}
