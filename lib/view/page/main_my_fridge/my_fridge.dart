import 'package:flutter/material.dart';
import 'package:leute/data/mock_repository/foods_repository.dart';
import 'package:leute/data/mock_repository/refrige_repository.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/styles/app_text_style.dart';

class MyFridge extends StatefulWidget {
  const MyFridge({super.key});

  @override
  State<MyFridge> createState() => _MyFridgeState();
}

class _MyFridgeState extends State<MyFridge> {
  final foodRepository = RegisterdFoodsRepository();
  final refrigeRepository = RegisterdRefrigeRepository();
  List<FoodDetail> myFoodDetails = [];
  List<RefrigeDetail> refrigeDetails = [];

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final allFoods = await foodRepository.getFirebaseFoodsData();
    myFoodDetails = foodRepository.getMyFoodDetail(allFoods, 'sangin');
    refrigeDetails = refrigeRepository.getRefrigeDetail();
    refrigeDetails.sort((a, b) => a.refrigeId.compareTo(b.refrigeId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Center(
            child: Text('나의 냉장고', style: AppTextStyle.header20()),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (var refrigeDetail in refrigeDetails)
                  Column(
                    children: [
                      Text(' ${refrigeDetail.refrigeName}'),
                      Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1 / 1,
                          ),
                          itemCount: myFoodDetails
                              .where(
                                  (e) => e.refrigeName == refrigeDetail.refrigeName)
                              .length,
                          itemBuilder: (context, index) {
                            return Image.network(myFoodDetails
                                .where((e) =>
                                    e.refrigeName == refrigeDetail.refrigeName)
                                .toList()[index]
                                .foodImage);
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
