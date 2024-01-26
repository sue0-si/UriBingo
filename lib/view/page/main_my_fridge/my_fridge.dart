import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view_model/my_fridge_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/repository/foods_repository.dart';
import '../../../data/repository/refrige_repository.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyFridgeViewModel>();
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
                for (var refrigeDetail in viewModel.refrigeDetails)
                  Column(
                    children: [
                      if (viewModel.myFoodDetails
                          .where(
                              (e) => e.refrigeName == refrigeDetail.refrigeName)
                          .isNotEmpty)
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
                          itemCount: viewModel.myFoodDetails
                              .where((e) =>
                                  e.refrigeName == refrigeDetail.refrigeName)
                              .length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                context.go('/myfooddetail', extra: [
                                  viewModel.myFoodDetails[index],
                                  refrigeDetail
                                ]);
                              },
                              child: Image.network(
                                viewModel.myFoodDetails
                                    .where((e) =>
                                        e.refrigeName ==
                                        refrigeDetail.refrigeName)
                                    .toList()[index]
                                    .foodImage,
                                fit: BoxFit.cover,
                              ),
                            );
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
