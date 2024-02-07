import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leute/domain/foods_repository.dart';

import '../models/foods_model.dart';

class RegisterdFoodsRepositoryImpl implements RegisterdFoodsRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
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

  @override
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

  @override
  List<FoodDetail> getMyFoodDetail(List<FoodDetail> allFoods, String userName,
      String groupName) {
    // final repository = RegisterdFoodsRepository();
    return allFoods
        .where((e) =>
            e.userName == userName &&
            e.groupName == groupName)
        .toList();
  }

  @override
  List<FoodDetail> getFoodDetail(
      List<FoodDetail> allFoods, String targetRefrigeName, String targetGroupName) {
    return allFoods.where((e) => e.refrigeName == targetRefrigeName && e.groupName == targetGroupName).toList();
  }
}
