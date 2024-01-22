import 'package:flutter/material.dart';
import 'package:leute/refrige_detail/data/foods_model/foods_model.dart';
import 'package:leute/refrige_detail/data/mock_repository/foods_repository.dart';
import 'package:leute/refrige_detail/data/mock_repository/refrige_repository.dart';
import 'package:leute/refrige_detail/data/refrige_model/refrige_model.dart';

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
    myFoodDetails = foodRepository.getMyFoodDetail(1);
    refrigeDetails = refrigeRepository.getRefrigeDetail();
    refrigeDetails.sort((a, b) => a.refrigeId.compareTo(b.refrigeId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('나의 냉장고'),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1,
                        ),
                        itemCount: myFoodDetails
                            .where(
                                (e) => e.refrigeId == refrigeDetail.refrigeId)
                            .length,
                        itemBuilder: (context, index) {
                          return Image.network(myFoodDetails
                              .where(
                                  (e) => e.refrigeId == refrigeDetail.refrigeId)
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
    );
  }
}
