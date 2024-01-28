import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/repository/foods_repository.dart';
import 'package:leute/data/repository/refrige_repository.dart';

class MyFridgeViewModel extends ChangeNotifier {
  final foodRepository = RegisterdFoodsRepository();
  final refrigeRepository = RegisterdRefrigeRepository();
  List<FoodDetail> myFoodDetails = [];
  List<RefrigeDetail> refrigeDetails = [];
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

  MyFridgeViewModel() {
    fetchMyFridgeData();
  }

  Future<void> fetchMyFridgeData() async {
    final allFoods = await foodRepository.getFirebaseFoodsData();
    refrigeDetails = await refrigeRepository.getFirebaseRefrigesData();
    myFoodDetails = foodRepository.getMyFoodDetail(
        allFoods, FirebaseAuth.instance.currentUser!.displayName!);
    // refrigeDetails;
    notifyListeners();
  }
}
