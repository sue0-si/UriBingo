import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';
import 'package:leute/view/widget/my_food_detail_page_widget/food_detail_image_widget.dart';
import 'package:leute/view_model/my_food_detail_view_model.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_widgets/super_container.dart';

class DiscardFoodDetail extends StatefulWidget {
  const DiscardFoodDetail(
      {super.key, required this.myFoodItem, required this.ourRefrigItem});

  final FoodDetail myFoodItem;
  final RefrigeDetail ourRefrigItem;

  @override
  State<DiscardFoodDetail> createState() => _DiscardFoodDetailState();
}

class _DiscardFoodDetailState extends State<DiscardFoodDetail> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<MyFoodDetailViewModel>()
          .calculateRemainPeriod(widget.myFoodItem, widget.ourRefrigItem);
      context
          .read<MyFoodDetailViewModel>()
          .checkOld(widget.myFoodItem, widget.ourRefrigItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyFoodDetailViewModel>();
    final dateFormat = DateFormat('yyyy년 MM월 dd일');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/discardPage');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodDetailImageWidget(
                  itemImage: widget.myFoodItem.foodImage,
                ),
              ),
            );
          },
          child: Hero(
            tag: 'imageTag',
            child: SuperContainer(
              height: 200.h,
              width: 300.w,
              border: 120.r,
              borderWidth: 9,
              borderColor:
                  viewModel.isOld ? AppColors.caution : const Color(0xFF9bc6bf),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.myFoodItem.foodImage),
              ),
            ),
          ),
        ),
        SizedBox(height: 32.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text('주  인: ${widget.myFoodItem.userName}',
                      style: AppTextStyle.body14R()),
                ],
              ),
              Row(
                children: [
                  Text(
                      '등록일: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.myFoodItem.registerDate))}',
                      style: AppTextStyle.body14R()),
                ],
              ),
              Row(
                children: [
                  Text('남은기간: ', style: AppTextStyle.body14R()),
                  Text(
                    '${viewModel.remainPeriod} 일',
                    style: AppTextStyle.body14R(
                        color: viewModel.isOld
                            ? AppColors.caution
                            : AppColors.mainText),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: 90.h),
              //남은 기간에 따라 다른 텍스트 출력
              viewModel.isOld
                  ? Text('곧 폐기됩니다.',
                      style: AppTextStyle.body14M(color: AppColors.caution))
                  : widget.myFoodItem.isExtended
                      ? Text('더이상 연장이 불가해요',
                          style:
                              AppTextStyle.body14M(color: AppColors.mainText))
                      : Text('아직은 연장이 불가해요',
                          style:
                              AppTextStyle.body14M(color: AppColors.mainText)),
              SizedBox(height: 110.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: const Color(0xFFcb7d74)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (desContext) {
                          return TwoAnswerDialog(
                              title: '삭제하시겠습니까?',
                              subtitle: '삭제 후 복구가 불가합니다',
                              firstButton: '네',
                              secondButton: '아니오',
                              // 함수호출
                              onTap: () {
                                viewModel.deleteFoodAndStorage(
                                    widget.myFoodItem, widget.ourRefrigItem);
                                if (mounted) {
                                  context.go('/discardPage');
                                }
                              });
                        });
                  },
                  child: Text('삭제하기',
                      style: AppTextStyle.body14R(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
