import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/data/repository/refrige_repository.dart';
import 'package:leute/view/page/main_my_fridge/main_screen.dart';
import 'package:leute/view/widget/main_my_fridge_widget/make_fridge_widget.dart';

class MainScreenViewModel extends ChangeNotifier {
  List<Widget> fridges = [];
  List<RefrigeDetail> refrigeItems = [];

  final UserDataRepository userDataRepository = UserDataRepository();
  bool isManager = false;
  bool isLoading = false;
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

  MainScreenViewModel() {
    fetchFridgeData();
  }

  Future<void> fetchFridgeData() async {
    isLoading = true;
    notifyListeners();

    try {
      //비동기로 변경
      refrigeItems =
          await RegisterdRefrigeRepository().getFirebaseRefrigesData();
      List<UserModel> userData = await userDataRepository.getFirebaseUserData();
      isManager = userData
          .firstWhere(
              (user) => user.email == FirebaseAuth.instance.currentUser!.email)
          .manager;

      for (int i = 1; i <= refrigeItems.length; i++) {
        fridges.add(MakeFridge(
            refrigeItems: refrigeItems, isManager: isManager, index: i - 1));
      }
    } catch (error) {
      // 에러 처리
      print('Error fetching data: $error');
    } finally {
      isLoading = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }
}
