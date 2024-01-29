import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leute/data/models/user_model.dart';

class UserDataRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getFirebaseUserData() async {
    // Firebase Firestore에서 데이터 읽어오기
    QuerySnapshot querySnapshot = await _firestore.collection('profile').get();

    // 데이터 파싱
    List<UserModel> data = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      data.add(UserModel.fromJson(document.data() as Map<String, dynamic>));
    });
    return data;
  }
}