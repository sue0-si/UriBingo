import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';

import '../../../data/models/foods_model.dart';
import '../../../data/repository/foods_repository_impl.dart';

class AddPageViewModel extends ChangeNotifier {
  final _repository = RegisterdFoodsRepositoryImpl();
  final coldStorageOfCompartmentsList =
      List.generate(11, (index) => '$index 칸'); //냉장고칸수
  final frozenStorageOfCompartmentsList =
      List.generate(11, (index) => '$index 칸'); //냉동고칸수
  final storagePeriodList =
      List.generate(30, (index) => '${index + 1} 일'); //보관기간
  final extensionPeriodList =
      List.generate(5, (index) => '${index + 1} 일'); //연장가능기간
  List<FoodDetail> _foodItems = [];

  List<FoodDetail> get foodItems => _foodItems;

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

  int registerdDate = 0;
  String initialName = '';

  //String name = ''; //validate 값 저장되는 변수
  String _name = '';

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  String _selectedColdstorage = '0 칸'; //선택된냉장칸수

  String get selectedColdstorage => _selectedColdstorage;

  set selectedColdstorage(String value) {
    _selectedColdstorage = value.toString();
  }

  String _selectedFrozenStorage = '0 칸'; //선택된냉동칸수

  String get selectedFrozenStorage => _selectedFrozenStorage;

  set selectedFrozenStorage(String value) {
    _selectedFrozenStorage = value.toString();
  }

  String _selectedStoragePeriod = '1 일'; //선택된보관기간

  String get selectedStoragePeriod => _selectedStoragePeriod;

  set selectedStoragePeriod(String value) {
    _selectedStoragePeriod = value.toString();
  }

  String _selectedExtensionPeriod = '1 일'; //선택된연장가능기간

  String get selectedExtensionPeriod => _selectedExtensionPeriod;

  set selectedExtensionPeriod(String value) {
    _selectedExtensionPeriod = value.toString();
  }

//getter 설정

  Future<void> addRefrige(UserModel currentUser) async {
    final registerDate = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection('refrigeDetails')
        .doc(registerDate + name)
        .set(RefrigeDetail(
                registerDate: int.parse(registerDate),
                refrigeName: name,
                freezerCompCount: int.parse(
                    selectedFrozenStorage.replaceAll(RegExp('\\D'), "")),
                period: int.parse(
                    selectedStoragePeriod.replaceAll(RegExp('\\D'), "")),
                refrigeCompCount: int.parse(
                    selectedColdstorage.replaceAll(RegExp('\\D'), "")),
                extentionPeriod: int.parse(
                    selectedExtensionPeriod.replaceAll(RegExp('\\D'), "")),
                validationCode: currentUser.validationCode,
                groupName: currentUser.groupName)
            .toJson());
    notifyListeners();
  }

//냉장고 수정 함수
  Future<void> editRefrige(
      String selectedColdstorage,
      String selectedFrozenStorage,
      String selectedStoragePeriod,
      String selectedExtensionPeriod,
      UserModel currentUser) async {
    await FirebaseFirestore.instance
        .collection('refrigeDetails')
        .doc(registerdDate.toString() + initialName)
        .update(RefrigeDetail(
                registerDate: registerdDate,
                refrigeName: name,
                refrigeCompCount: int.parse(
                    selectedColdstorage.replaceAll(RegExp('\\D'), "")),
                freezerCompCount: int.parse(
                    selectedFrozenStorage.replaceAll(RegExp('\\D'), "")),
                period: int.parse(
                    selectedStoragePeriod.replaceAll(RegExp('\\D'), "")),
                extentionPeriod: int.parse(
                    selectedExtensionPeriod.replaceAll(RegExp('\\D'), "")),
                validationCode: currentUser.validationCode,
                groupName: currentUser.groupName)
            .toJson());
    notifyListeners();
  }

  // 냉장고 삭제 전 남은 음식 확인
  Future<void> remainFoodsCheck(String refrigeName) async {
    final allFoods = await _repository.getFirebaseFoodsData();
    _foodItems = allFoods.where((e) => e.refrigeName == refrigeName).toList();
    notifyListeners();
  }

  // 냉장고 삭제 함수
  Future<void> deleteRefrige() async {
    await Future.wait([
      FirebaseFirestore.instance
          .collection('refrigeDetails')
          .doc(registerdDate.toString() + initialName)
          .delete(),
    ]);
    if (_foodItems.isNotEmpty) {
      for (int i = 0; i < _foodItems.length; i++) {
        await Future.wait([
          FirebaseFirestore.instance
              .collection('foodDetails')
              .doc(_foodItems[i].registerDate.toString() + _foodItems[i].userId)
              .delete(),
          FirebaseStorage.instance
              .ref("images/${_foodItems[i].registerDate}.jpg")
              .delete()
        ]);
      }
    }

    notifyListeners();
  }
}
