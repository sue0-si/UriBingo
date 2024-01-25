import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data/models/refrige_model.dart';

class EditPageViewModel extends ChangeNotifier {

  Future<void> changeColdstorage() async {
    await FirebaseFirestore.instance
        .collection('refrigeDetails')
        .(RefrigeDetail(
      refrigeName: name,
      freezerCompCount: int.parse(selectedFrozenStorage[0]),
      period: int.parse(selectedStoragePeriod[0]),
      refrigeCompCount: int.parse(selectedColdstorage[0]),
      extentionPeriod: int.parse(selectedExtensionPeriod[0]),
    ).toJson());
    notifyListeners();
  }
}