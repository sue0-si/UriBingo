import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/user_data_repository.dart';

class GroupSettingPageViewModel with ChangeNotifier {
  final UserDataRepository userDataRepository;

  GroupSettingPageViewModel({
    required this.userDataRepository,
  }) {
    fetchData();
  }

  bool isLoading = false;

  final List<UserModel> _groupUsers = [];

  List<UserModel> get groupUsers => _groupUsers;

  List<UserModel> groupUserList = [];
  List<UserModel> fetchedUserList = [];
  List<UserModel> addTargetMember = [];
  bool isMember = false;
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

  //
  Future<void> fetchData() async {
    isLoading = true;
    notifyListeners();
    try {
      // 관리자 여부 확인용 메서드
      List<UserModel> allUserData = await userDataRepository.getFirebaseUserData();
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

  // 그룹원 검색 함수
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

  // 그룹원 상태 변경 함수
  Future<void> editGroupUser(List<UserModel> groupUsers) async {
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
            userId: targetUser.userId,
          ).toJson());
    }
    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // 미그룹원 검색 함수
  Future<void> searchNoGroupUser(String userEmail) async {
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    List<UserModel> noGroupUsers =
        userData.where((e) => e.validationCode == '').toList();
    addTargetMember +=
        noGroupUsers.where((user) => user.email == userEmail).toList();
    notifyListeners();
  }

  // 그룹에 멤버 추가 함수
  Future<void> addToMember(UserModel user) async {
    if (addTargetMember.isEmpty) {
      isLoading = false;
      notifyListeners();
    } else {
      UserModel manager = fetchedUserList.firstWhere(
          (user) => user.email == FirebaseAuth.instance.currentUser?.email);
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(addTargetMember[0].userId)
          .update(UserModel(
            validationCode: manager.validationCode,
            email: addTargetMember[0].email,
            employeeNumber: addTargetMember[0].employeeNumber,
            manager: false,
            name: addTargetMember[0].name,
            groupName: manager.groupName,
            userId: addTargetMember[0].userId,
          ).toJson());
      isMember = true;
      addTargetMember.remove(user);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // 사용자 그룹탈퇴 체크박스
  void withdrawUserCheckBoxTap(UserModel targetUser) {
    fetchedUserList
        .where((user) => user == targetUser)
        .map((e) => e..validationCode = '')
        .toList()
        .map((e) => e..groupName = '')
        .toList()
        .map((e) => e..manager = false);

    notifyListeners();
  }

  // 관리자 - 사용자 변경 체크박스
  void managerCheckBoxTap(UserModel targetUser) {
    fetchedUserList
        .where((user) => user == targetUser)
        .map((e) => e..manager = !e.manager)
        .toList();
    notifyListeners();
  }

// void checkNoManager()
}
