import '../data/models/foods_model.dart';

abstract interface class RegisterdFoodsRepository {
  Future<List<FoodDetail>> getFirebaseFoodsData();

  List<dynamic> filterFoods(
      List<FoodDetail> foodsToFilter, bool targetFreezed, int targetPositionId);

  List<FoodDetail> getMyFoodDetail(List<FoodDetail> allFoods, String userName);

  List<FoodDetail> getFoodDetail(
      List<FoodDetail> allFoods, String targetRefrigeName);
}
