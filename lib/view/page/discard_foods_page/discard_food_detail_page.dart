import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view_model/my_food_detail_view_model.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/my_food_detail_page_widget/food_detail_image_widget.dart';
import 'package:provider/provider.dart';

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
            child: Container(
              height: 200.h,
              width: 300.w,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.network(widget.myFoodItem.foodImage,
                    fit: BoxFit.cover),
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
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50]),
                    //남은 기간이 2일 미만-> 다이얼로그 생성 / 2일 이상 ->버튼 비활성화
                    onPressed: context.watch<MyFoodDetailViewModel>().isOld
                        ? () {
                      showDialog(
                          context: context,
                          builder: (desContext) {
                            return TwoAnswerDialog(
                                title: '연장하시겠습니까?',
                                firstButton: '네',
                                secondButton: '아니오',
                                onTap: () {
                                  //'네' 클릭 -> 함수호출
                                  viewModel.isOld = false;
                                  viewModel.extendPeriod(
                                      widget.myFoodItem,
                                      widget.ourRefrigItem);
                                  viewModel
                                      .updateFirestore(widget.myFoodItem);
                                  Navigator.of(context).pop();
                                });
                          });
                    }
                    //연장버튼 비활성화
                        : null,
                    child: const Text('연장하기'),
                  )
                ],
              ),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (desContext) {
                              return TwoAnswerDialog(
                                  title: '등록한 음식을 삭제하시겠습니까?',
                                  firstButton: '네',
                                  secondButton: '아니오',
                                  // 함수호출
                                  onTap: () {
                                    viewModel.deleteFoodAndStorage(
                                        widget.myFoodItem,
                                        widget.ourRefrigItem);
                                    if (mounted) {
                                      context.go('/', extra: 1);
                                    }
                                  });
                            });
                      },
                      child: const Text('삭제하기')),
                ],
              ),
              SizedBox(height: 32.h),
              //남은 기간에 따라 다른 텍스트 출력
              viewModel.isOld
                  ? Text('곧 폐기됩니다.',
                  style: AppTextStyle.body14R(color: AppColors.caution))
                  : widget.myFoodItem.isExtended
                  ? const Text('더이상 연장이 불가해요')
                  : const Text('아직은 연장이 불가해요')
            ],
          ),
        ),
      ]),
    );
  }
}
