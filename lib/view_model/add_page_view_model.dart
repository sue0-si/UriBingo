import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leute/data/models/refrige_model.dart';

class AddPageViewModel extends ChangeNotifier {
  final coldStorageOfCompartmentsList = [
    '0칸',
    '1칸',
    '2칸',
    '3칸',
    '4칸',
    '5칸'
  ]; //냉장고칸수
  final frozenStorageOfCompartmentsList = [
    '0칸',
    '1칸',
    '2칸',
    '3칸',
    '4칸',
    '5칸'
  ]; //냉동고칸수
  final storagePeriodList = ['1일', '2일', '3일', '4일', '5일']; //보관기간
  final extensionPeriodList = ['1일', '2일', '3일', '4일', '5일']; //연장가능기간

  int registerdDate = 0;
  String initialName = '';

  //String name = ''; //validate 값 저장되는 변수
  String _name = '';

  String get name => _name;


  set name(String value) {
    _name = value;
  }

  String _selectedColdstorage = '0칸'; //선택된냉장칸수

  String get selectedColdstorage => _selectedColdstorage;

  set selectedColdstorage(String value) {
    _selectedColdstorage = value.toString();
  }

  String _selectedFrozenStorage = '0칸'; //선택된냉동칸수

  String get selectedFrozenStorage => _selectedFrozenStorage;
  set selectedFrozenStorage(String value) {
    _selectedFrozenStorage = value.toString();
  }

  String _selectedStoragePeriod = '1일'; //선택된보관기간

  String get selectedStoragePeriod => _selectedStoragePeriod;
  set selectedStoragePeriod(String value) {
    _selectedStoragePeriod = value.toString();
  }

  String _selectedExtensionPeriod = '1일'; //선택된연장가능기간

  String get selectedExtensionPeriod => _selectedExtensionPeriod;
  set selectedExtensionPeriod(String value) {
    _selectedExtensionPeriod = value.toString();
  }
  notifyListeners();
//getter 설정




  Future<void> addRefrige() async {
    final registerDate = DateTime.now().millisecondsSinceEpoch.toString();
    await FirebaseFirestore.instance
        .collection('refrigeDetails')
        .doc(registerDate + name)
        .set(RefrigeDetail(
          registerDate: int.parse(registerDate),
          refrigeName: name,
          freezerCompCount: int.parse(selectedFrozenStorage[0]),
          period: int.parse(selectedStoragePeriod[0]),
          refrigeCompCount: int.parse(selectedColdstorage[0]),
          extentionPeriod: int.parse(selectedExtensionPeriod[0]),
        ).toJson());
    notifyListeners();
  }

  Future<void> editRefrige() async {
    await FirebaseFirestore.instance
        .collection('refrigeDetails')
        .doc(registerdDate.toString() + initialName)
        .update(RefrigeDetail(
          registerDate: registerdDate,
          refrigeName: name,
          freezerCompCount: int.parse(selectedFrozenStorage[0]),
          period: int.parse(selectedStoragePeriod[0]),
          refrigeCompCount: int.parse(selectedColdstorage[0]),
          extentionPeriod: int.parse(selectedExtensionPeriod[0]),
        ).toJson());
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
    notifyListeners();
  }
}
