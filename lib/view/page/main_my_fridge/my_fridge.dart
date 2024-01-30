import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_widgets/super_container.dart';
import 'package:leute/view_model/my_fridge_view_model.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

class MyFridge extends StatelessWidget {
  const MyFridge({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyFridgeViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            '나의냉장고',
            style: AppTextStyle.header22(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: viewModel.isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xFF9bc6bf),
                size: 50,
              ),
            )
          : viewModel.myFoodDetails.isEmpty
              ? const Center(
                  child: Text('보관중인 음식이 없습니다.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        for (var refrigeDetail in viewModel.refrigeDetails)
                          Column(
                            children: [
                              if (viewModel.myFoodDetails
                                  .where((e) =>
                                      e.refrigeName ==
                                      refrigeDetail.refrigeName)
                                  .isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.grey.shade300),
                                  child: Text(
                                    ' ${refrigeDetail.refrigeName}',
                                  ),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 1 / 1,
                                  ),
                                  itemCount: viewModel.myFoodDetails
                                      .where((e) =>
                                          e.refrigeName ==
                                          refrigeDetail.refrigeName)
                                      .length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        context.go('/myfooddetail', extra: [
                                          viewModel.myFoodDetails
                                              .where((e) =>
                                                  e.refrigeName ==
                                                  refrigeDetail.refrigeName)
                                              .toList()[index],
                                          refrigeDetail
                                        ]);
                                      },
                                      child: SuperContainer(
                                        height: 90.h,
                                        width: 100.w,
                                        border: 80,
                                        borderWidth: 5,
                                        borderColor: const Color(0xFF9bc6bf),
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
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
