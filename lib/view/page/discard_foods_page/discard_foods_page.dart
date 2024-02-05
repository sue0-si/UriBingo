import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_widgets/super_container.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import 'discard_foods_view_model.dart';

class DiscardFoods extends StatelessWidget {
  const DiscardFoods({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DiscardFoodsViewModel>();
    final state = viewModel.state;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => context.go('/main_page', extra: 0)),
        title: Text(
          '폐기할음식들',
          style: AppTextStyle.header20(color: Colors.white),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10)),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: state.isLoading
          ? Center(
              child: LoadingAnimationWidget.inkDrop(
                color: const Color(0xFF9bc6bf),
                size: 50,
              ),
            )
          : state.discardFoodsDetails.isEmpty
              ? const Center(
                  child: Text('폐기예정인 음식이 없습니다.'),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      for (var refrigeDetail in state.refrigeDetails)
                        Column(
                          children: [
                            if (state.discardFoodsDetails
                                .where((e) =>
                                    e.refrigeName == refrigeDetail.refrigeName)
                                .isNotEmpty)
                              Text(' ${refrigeDetail.refrigeName}'),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: 1 / 1,
                              ),
                              itemCount: state.discardFoodsDetails
                                  .where((e) =>
                                      e.refrigeName ==
                                      refrigeDetail.refrigeName)
                                  .length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context.go('/discardFoodDetail', extra: [
                                      state.discardFoodsDetails
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
                                        state.discardFoodsDetails
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
                          ],
                        ),
                    ],
                  )),
                ),
    );
  }
}
