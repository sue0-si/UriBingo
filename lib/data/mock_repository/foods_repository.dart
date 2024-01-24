import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/foods_model.dart';

class RegisterdFoodsRepository {
  // final List<FoodDetail> foods = [
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 1,
  //     foodId: '1',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '1',
  //     userName: 'sungdae',
  //     registerDate: 1705995688660,
  //     remainPeriod: 2, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 1,
  //     foodId: '1',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '1',
  //     userName: 'sungdae',
  //     registerDate: 1705995688660,
  //     remainPeriod: 2, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 1,
  //     foodId: '2',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '1',
  //     userName: 'sungdae',
  //     registerDate: 1705995688660,
  //     remainPeriod: 3, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: true,
  //     positionId: 1,
  //     foodId: '3',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '2',
  //     userName: 'sangin',
  //     registerDate: 1705995688660,
  //     remainPeriod: 0, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 2,
  //     foodId: '4',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '2',
  //     userName: 'sangin',
  //     registerDate: 1705995688660,
  //     remainPeriod: 2, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 2,
  //     foodId: '4',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '2',
  //     userName: 'sangin',
  //     registerDate: 1705995688660,
  //     remainPeriod: 2, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 2,
  //     foodId: '4',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '2',
  //     userName: 'sangin',
  //     registerDate: 1705995688660,
  //     remainPeriod: 2, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 2,
  //     foodId: '5',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '1',
  //     userName: 'sungdae',
  //     registerDate: 1705995688660,
  //     remainPeriod: 2, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 3,
  //     foodId: '6',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '3',
  //     userName: 'eunjin',
  //     registerDate: 1705995688660,
  //     remainPeriod: 7, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 3,
  //     foodId: '7',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '3',
  //     userName: 'eunjin',
  //     registerDate: 1705995688660,
  //     remainPeriod: 8, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 2,
  //     foodId: '8',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '4',
  //     userName: 'dahee',
  //     registerDate: 1705995688660,
  //     remainPeriod: 5, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 1,
  //     foodId: '9',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '5',
  //     userName: 'soohyun',
  //     registerDate: 1705995688660,
  //     remainPeriod: 6, isPublic: false, isUnknown: false,
  //   ),
  //   FoodDetail(
  //     refrigeId: '1',
  //     freezed: false,
  //     positionId: 4,
  //     foodId: '9',
  //     foodImage:
  //         'https://wallpaperswide.com/download/mango_fruits-wallpaper-1920x1080.jpg',
  //     userId: '5',
  //     userName: 'soohyun',
  //     registerDate: 1705995688660,
  //     remainPeriod: 6, isPublic: false, isUnknown: false,
  //   ),
  // ];

  List<FoodDetail> getFoodDetail(List<FoodDetail> allFoods, String targetRefrigeName) {
    return allFoods.where((e) => e.refrigeName == targetRefrigeName).toList();
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


  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<FoodDetail>> getFirebaseFoodsData() async {
    // Firebase Firestore에서 데이터 읽어오기
    QuerySnapshot querySnapshot =
        await _firestore.collection('foodDetails').get();

    // 데이터 파싱
    List<FoodDetail> data = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      data.add(FoodDetail.fromJson(document.data() as Map<String, dynamic>));
    });

    return data;
  }

  List<FoodDetail> getMyFoodDetail(List<FoodDetail> allFoods, String userName) {
    // final repository = RegisterdFoodsRepository();
    return allFoods.where((e) => e.userName == userName).toList();
  }
}
