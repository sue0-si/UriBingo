import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../data/models/refrige_model.dart';

class AddRefrigeViewModel extends ChangeNotifier {
  final coldStorageOfCompartments = ['1칸', '2칸', '3칸', '4칸', '5칸']; //냉장고칸수
  final frozenStorageOfCompartments = ['1칸', '2칸', '3칸', '4칸', '5칸']; //냉동고칸수
  final storagePeriod = ['1일', '2일', '3일', '4일', '5일']; //보관기간
  final extensionPeriod = ['1일', '2일', '3일', '4일', '5일']; //연장가능기간

  String selectedColdstorage = '1칸'; //선택된냉장칸수
  String selectedFrozenStorage = '1칸'; //선택된냉동칸수
  String selectedStoragePeriod = '1일'; //선택된보관기간
  String selectedExtensionPeriod = '1일'; //선택된연장가능기간
  String name = ''; //validate 값 저장되는 변수

  Future<void> addRefrigeToStorage() async {
    await FirebaseFirestore.instance
        .collection('refrigeDetails')
        .add(RefrigeDetail(
          extentionPeriod: int.parse(selectedExtensionPeriod[0]),
          freezerCompCount: int.parse(selectedFrozenStorage[0]),
          period: int.parse(selectedStoragePeriod[0]),
          refrigeCompCount: int.parse(selectedColdstorage[0]),
          refrigeName: name,
        ).toJson());
  }
  notifyListeners();
}
