import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/view/page/main_my_fridge/main_screen_state.dart';
import 'package:leute/view/widget/main_my_fridge_widget/make_fridge_widget.dart';

import '../../../data/repository/refrige_repository_impl.dart';
import '../../../domain/user_data_repository.dart';

class MainScreenViewModel extends ChangeNotifier {
  final UserDataRepository userDataRepository;

  MainScreenViewModel({
    required this.userDataRepository,
  }) {
    fetchFridgeData();
  }

  List<Widget> fridges = [];

  MainScreenState _state = const MainScreenState();

  MainScreenState get state => _state;

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

  Future<void> fetchFridgeData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();

    try {
      //비동기로 변경
      List<UserModel> userData = await userDataRepository.getFirebaseUserData();
      _state = state.copyWith(
          currentUser: userData.firstWhere((user) =>
              user.email == FirebaseAuth.instance.currentUser!.email));

      if (state.currentUser == null) {
        _state = state.copyWith(isLoading: true);
        notifyListeners();
      }
      final allRefrigeItems =
          await RegisterdRefrigeRepositoryImpl().getFirebaseRefrigesData();
      _state = state.copyWith(
          refrigeItems: allRefrigeItems
              .where(
                  (e) => e.validationCode == state.currentUser!.validationCode)
              .toList());

      for (int i = 1; i <= state.refrigeItems.length; i++) {
        fridges.add(MakeFridge(
            refrigeItems: state.refrigeItems,
            currentUser: state.currentUser!,
            index: i - 1));
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
}
