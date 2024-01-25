import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/foods_model.dart';

class RegisterdFoodsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FoodDetail>> getFirebaseFoodsData() async {
    // Firebase Firestore에서 데이터 읽어오기
    QuerySnapshot querySnapshot = await _firestore
        .collection('foodDetails')
        .orderBy('registerDate', descending: true)
        .get();

    // 데이터 파싱
    List<FoodDetail> data = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      data.add(FoodDetail.fromJson(document.data() as Map<String, dynamic>));
    });
    return data;
  }

  List<dynamic> filterFoods(List<FoodDetail> foodsToFilter, bool targetFreezed,
      int targetPositionId) {
    return [
      targetFreezed,
      targetPositionId,
      foodsToFilter
          .where((food) =>
              food.freezed == targetFreezed &&
              food.positionId == targetPositionId)
          .toList()
    ];
  }

  List<FoodDetail> getMyFoodDetail(List<FoodDetail> allFoods, String userName) {
    // final repository = RegisterdFoodsRepository();
    return allFoods.where((e) => e.userName == userName).toList();
  }
}

List<FoodDetail> getFoodDetail(
    List<FoodDetail> allFoods, String targetRefrigeName) {
  return allFoods.where((e) => e.refrigeName == targetRefrigeName).toList();
}
