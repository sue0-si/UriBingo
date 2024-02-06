import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/user_data_repository.dart';
import 'group_setting_state.dart';

class GroupSettingPageViewModel with ChangeNotifier {
  final UserDataRepository userDataRepository;

  GroupSettingPageViewModel({
    required this.userDataRepository,
  }) {
    fetchData();
  }

  GroupSettingState _state = const GroupSettingState();

  GroupSettingState get state => _state;

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

  // 같은 그룹의 유저 fetch 함수
  Future<void> fetchData() async {
    _state = state.copyWith(isLoading: true);
    notifyListeners();
    try {
      // 관리자 여부 확인용 메서드
      List<UserModel> allUserData =
          await userDataRepository.getFirebaseUserData();
      UserModel currentUser = allUserData.firstWhere(
          (user) => user.email == FirebaseAuth.instance.currentUser?.email);
      _state = state.copyWith(
        fetchedUserList: allUserData
            .where((e) => e.validationCode == currentUser.validationCode)
            .toList(),
      );
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

  // 그룹원 찾기 기능 구현 함수
  void searchUser(String query) async {
    _state = state.copyWith(isLoading: true);
    await fetchData();
    notifyListeners();
    _state = state.copyWith(
        fetchedUserList: _state.fetchedUserList
            .where((user) =>
                (user.name.contains(query) || user.email.contains(query)))
            .toList(),
        isLoading: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // 그룹원 상태 변경 함수
  Future<void> editGroupUser(List<UserModel> groupUsers) async {
    _state = state.copyWith(isLoading: true);
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
    _state = state.copyWith(isLoading: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  // 미그룹원 검색 함수
  Future<void> searchNoGroupUser(String userEmail) async {
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    List<UserModel> noGroupUsers =
        userData.where((e) => e.validationCode == '').toList();
    _state = state.copyWith(
        addTargetMember: _state.addTargetMember +
            noGroupUsers.where((user) => user.email == userEmail).toList());
    notifyListeners();
  }

  // 그룹에 멤버 추가 함수
  Future<void> addToMember(UserModel user) async {
    if (_state.addTargetMember.isEmpty) {
      _state = state.copyWith(isLoading: false);
      notifyListeners();
    } else {
      UserModel manager = _state.fetchedUserList.firstWhere(
          (user) => user.email == FirebaseAuth.instance.currentUser?.email);
      await FirebaseFirestore.instance
          .collection('profile')
          .doc(_state.addTargetMember[0].userId)
          .update(UserModel(
            validationCode: manager.validationCode,
            email: _state.addTargetMember[0].email,
            employeeNumber: _state.addTargetMember[0].employeeNumber,
            manager: false,
            name: _state.addTargetMember[0].name,
            groupName: manager.groupName,
            userId: _state.addTargetMember[0].userId,
          ).toJson());
      _state = state.copyWith(
          isMember: true,
          addTargetMember: _state.addTargetMember..remove(user));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  // 사용자 그룹탈퇴 체크박스
  void withdrawUserCheckBoxTap(UserModel targetUser) {
    _state = state.copyWith(
        fetchedUserList: _state.fetchedUserList
          ..where((user) => user == targetUser)
          ..map((e) => e..validationCode = '')
          ..map((e) => e..groupName = '')
          ..map((e) => e..manager = false));
    notifyListeners();
  }

  // 관리자 - 사용자 변경 체크박스
  void managerCheckBoxTap(UserModel targetUser) {
    _state = state.copyWith(
        fetchedUserList: _state.fetchedUserList
          ..where((user) => user == targetUser)
          ..map((e) => e..manager = !e.manager)
          );
    notifyListeners();
  }

// void checkNoManager()
}
