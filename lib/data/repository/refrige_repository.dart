import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/refrige_model.dart';

class RegisterdRefrigeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RefrigeDetail>> getFirebaseRefrigesData() async {
    // Firebase Firestore에서 데이터 읽어오기
    QuerySnapshot querySnapshot = await _firestore
        .collection('refrigeDetails')
        .orderBy('registerDate', descending: false)
        .get();

    // 데이터 파싱
    List<RefrigeDetail> data = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      data.add(RefrigeDetail.fromJson(document.data() as Map<String, dynamic>));
    });
    return data;
  }
}
