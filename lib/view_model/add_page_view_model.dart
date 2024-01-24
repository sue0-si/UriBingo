import 'package:flutter/material.dart';

class AddPageViewModel extends ChangeNotifier {


  final coldStorageOfCompartmentsList = ['1칸', '2칸', '3칸', '4칸', '5칸']; //냉장고칸수
  final frozenStorageOfCompartmentsList = ['1칸', '2칸', '3칸', '4칸', '5칸'];//냉동고칸수
  final storagePeriodList = ['1일', '2일', '3일', '4일', '5일']; //보관기간
  final extensionPeriodList = ['1일', '2일', '3일', '4일', '5일']; //연장가능기간

  String? _name; //validate 값 저장되는 변수

  String? get name => _name;

  set name(String? value) {
    _name = value;
    notifyListeners();
  }

  String _selectedColdstorage = '0'; //선택된냉장칸수

  String get selectedColdstorage => _selectedColdstorage;

  set selectedColdstorage(String value) {
    _selectedColdstorage = value as String;
    notifyListeners();
  }

  String _selectedFrozenStorage = '0'; //선택된냉동칸수

  String get selectedFrozenStorage => _selectedFrozenStorage;

  set selectedFrozenStorage(String value) {
    _selectedColdstorage = value as String;
    notifyListeners();
  }

  String _selectedStoragePeriod = '0'; //선택된보관기간

  String get selectedStoragePeriod => _selectedStoragePeriod;

  set selectedStoragePeriod(String value) {
    _selectedColdstorage = value as String;
    notifyListeners();
  }

  String _selectedExtensionPeriod = '0'; //선택된연장가능기간

  String get selectedExtensionPeriod => _selectedExtensionPeriod;

  set selectedExtensionPeriod(String value) {
    _selectedColdstorage = value as String;
    notifyListeners();
  }

//getter 설정



  void changeColdstorage(int value) {
    _selectedColdstorage = value.toString();
    notifyListeners();
  }
}
