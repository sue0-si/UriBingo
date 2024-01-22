import '../foods_model/foods_model.dart';

class RegisterdFoodsRepository {
  final List<FoodDetail> foods = [
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 1,
      foodId: 1,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 1,
      userName: 'sungdae',
      registerDate: '2023-12-22 17:45',
      remainPeriod: 2,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 1,
      foodId: 1,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 1,
      userName: 'sungdae',
      registerDate: '2023-12-22 17:45',
      remainPeriod: 2,
    ),
    FoodDetail(
      refrigeId: 2,
      freezed: false,
      positionId: 1,
      foodId: 2,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 1,
      userName: 'sungdae',
      registerDate: '2023-12-23 17:45',
      remainPeriod: 3,
    ),
    FoodDetail(
      refrigeId: 2,
      freezed: true,
      positionId: 1,
      foodId: 3,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 2,
      userName: 'sangin',
      registerDate: '2023-12-20 17:45',
      remainPeriod: 0,
    ),
    FoodDetail(
      refrigeId: 2,
      freezed: false,
      positionId: 2,
      foodId: 4,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 2,
      userName: 'sangin',
      registerDate: '2023-12-22 17:45',
      remainPeriod: 2,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 2,
      foodId: 4,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 2,
      userName: 'sangin',
      registerDate: '2023-12-22 17:45',
      remainPeriod: 2,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 2,
      foodId: 4,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 2,
      userName: 'sangin',
      registerDate: '2023-12-22 17:45',
      remainPeriod: 2,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 2,
      foodId: 5,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 1,
      userName: 'sungdae',
      registerDate: '2023-12-22 17:45',
      remainPeriod: 2,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 3,
      foodId: 6,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 3,
      userName: 'eunjin',
      registerDate: '2023-12-27 17:45',
      remainPeriod: 7,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 3,
      foodId: 7,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 3,
      userName: 'eunjin',
      registerDate: '2023-12-28 17:45',
      remainPeriod: 8,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 2,
      foodId: 8,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 4,
      userName: 'dahee',
      registerDate: '2023-12-25 17:45',
      remainPeriod: 5,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 1,
      foodId: 9,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 5,
      userName: 'soohyun',
      registerDate: '2023-12-26 17:45',
      remainPeriod: 6,
    ),
    FoodDetail(
      refrigeId: 1,
      freezed: false,
      positionId: 4,
      foodId: 9,
      foodImage:
          'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
      userId: 5,
      userName: 'soohyun',
      registerDate: '2023-12-26 17:45',
      remainPeriod: 6,
    ),
  ];

  List<FoodDetail> getFoodDetail(int num) {
    return foods.where((e) => e.refrigeId == num).toList();
  }

  List<FoodDetail> getMyFoodDetail(int userId) {
    // final repository = RegisterdFoodsRepository();
    return foods.where((e) => e.userId == userId).toList();
  }

  List<FoodDetail> filterFoods(List<FoodDetail> foodsToFilter,
      bool targetFreezed, int targetPositionId) {
    return foodsToFilter
        .where((food) =>
            food.freezed == targetFreezed &&
            food.positionId == targetPositionId)
        .toList();
  }
}
