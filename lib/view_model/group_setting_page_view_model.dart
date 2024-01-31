import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/repository/user_data_repository.dart';

import '../data/models/user_model.dart';

class GroupSettingPageViewModel with ChangeNotifier {
  final UserDataRepository _repository = UserDataRepository();

  bool isLoading = false;

  final List<UserModel> _groupUsers = [];

  List<UserModel> get groupUsers => _groupUsers;

  List<UserModel> groupUserList = [];
  List<UserModel> fetchedUserList = [];
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

  GroupSettingPageViewModel() {
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();
    try {
      // 관리자 여부 확인용 메서드
      List<UserModel> allUserData = await _repository.getFirebaseUserData();
      UserModel currentUser = allUserData.firstWhere(
          (user) => user.email == FirebaseAuth.instance.currentUser?.email);
      fetchedUserList = allUserData
          .where((e) => e.validationCode == currentUser.validationCode)
          .toList();
      groupUserList = fetchedUserList;
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

  void searchUser(String query) async {
    isLoading = true;
    await fetchData();
    notifyListeners();
    fetchedUserList = fetchedUserList
        .where(
            (user) => (user.name.contains(query) || user.email.contains(query)))
        .toList();
    // print(fetchedUserList.length);
    // print(groupUserList.length);

    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // 관리자 변경 함수
  Future<void> editManager(List<UserModel> groupUsers) async {
    isLoading = true;
    notifyListeners();
    // List<UserModel> userData = await _repository.getFirebaseUserData();
    // notifyListeners();
    for (var targetUser in groupUsers) {
      // final targetedUser = fetchedUserList.firstWhere((user) => user.email == targetUser.email);
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(targetUser.userId)
          .update(UserModel(
                  validationCode: targetUser.validationCode,
                  email: targetUser.email,
                  employeeNumber: targetUser.employeeNumber,
                  manager: targetUser.manager,
                  name: targetUser.name,
                  groupName: targetUser.groupName,
                  userId: targetUser.userId)
              .toJson());
    }
    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // 사용자 삭제 함수
  Future<void> deleteUser() async {
    await Future.wait([
      FirebaseFirestore.instance
          .collection('profile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .delete(),
    ]);
    notifyListeners();
  }

  void managerCheckBoxTap(UserModel targetUser) {
    fetchedUserList
        .where((user) => user == targetUser)
        .map((e) => e..manager = !e.manager)
        .toList();
    notifyListeners();
  }

// void checkNoManager()
}
