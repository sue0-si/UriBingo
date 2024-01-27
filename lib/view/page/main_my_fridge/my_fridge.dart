import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view_model/my_fridge_view_model.dart';
import 'package:provider/provider.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              '나의냉장고',
              style: AppTextStyle.header20(color: Colors.white),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Color(0xFF254e7a),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Consumer<MyFridgeViewModel>(
              builder: (context, viewModel, child) {
                return Column(
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
                                  child: Container(
                                    height: 20.h,
                                    width: 30.w,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          viewModel.myFoodDetails
                                              .where((e) =>
                                          e.refrigeName ==
                                              refrigeDetail.refrigeName)
                                              .toList()[index]
                                              .foodImage,
                                        ),
                                      ),
                                      shape: const SquircleBorder(
                                        radius: BorderRadius.all(
                                          Radius.circular(70.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
