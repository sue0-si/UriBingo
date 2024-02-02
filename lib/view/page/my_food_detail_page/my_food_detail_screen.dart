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
import '../../widget/custom_dialog/no_two_answer_dialog.dart';
import '../../widget/custom_widgets/super_container.dart';

class MyFoodDetail extends StatefulWidget {
  const MyFoodDetail(
      {super.key, required this.myFoodItem, required this.ourRefrigItem});

  final FoodDetail myFoodItem;
  final RefrigeDetail ourRefrigItem;

  @override
  State<MyFoodDetail> createState() => _MyFoodDetailState();
}

class _MyFoodDetailState extends State<MyFoodDetail> {
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
            context.go('/main_page', extra: 1);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        //음식 이미지 확대
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
          //음식 이미지
          child: Hero(
            tag: 'imageTag',
            child: SuperContainer(
              height: 200.h,
              width: 280.w,
              border: 170.r,
              borderWidth: 15.w,
              //남은 기간, 공용 여부에 따라 border 색상 변경
              borderColor: widget.myFoodItem.isPublic
                  ? const Color(0xFFFFE088)
                  : viewModel.isOld
                      ? AppColors.caution
                      : const Color(0xFF9bc6bf),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(widget.myFoodItem.foodImage),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 45.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                      '등록일: ${dateFormat.format(DateTime.fromMillisecondsSinceEpoch(widget.myFoodItem.registerDate))}',
                      style: AppTextStyle.body15R()),
                ],
              ),
              SizedBox(height: 8.h),
              //공용음식 여부 체크
              widget.myFoodItem.isPublic
                  ? const Text('')
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('남은기간: ', style: AppTextStyle.body15R()),
                        //남은 기간에 따라 텍스트 색상 변경
                        Text(
                          '${viewModel.remainPeriod}일',
                          style: AppTextStyle.body15B(
                              color: viewModel.isOld
                                  ? AppColors.caution
                                  : AppColors.mainText),
                        ),
                        const Spacer(),
                      ],
                    ),
              SizedBox(height: 40.h),
              //남은 기간, 공용 여부에 따라 다른 텍스트 출력
              widget.myFoodItem.isPublic
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('공용 음식이에요 ', style: AppTextStyle.body16R()),
                        Image.asset('assets/images/share-food-icon.png',
                            width: 40.w, height: 40.h)
                      ],
                    )
                  : viewModel.isOld
                      ? Text('곧 폐기됩니다.',
                          style: AppTextStyle.body16B(color: AppColors.caution))
                      : widget.myFoodItem.isExtended
                          ? Text('더이상 연장이 불가해요',
                              style: AppTextStyle.body16R(
                                  color: AppColors.mainText))
                          : Text('아직은 연장이 불가해요',
                              style: AppTextStyle.body16R(
                                  color: AppColors.mainText)),
              SizedBox(height: 24.h),
              //공용음식일 경우 연장버튼 안보임
              widget.myFoodItem.isPublic
                  ? const Text('')
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r)),
                            backgroundColor: const Color(0xFF9DCFD4)),
                        //남은 기간이 2일 미만일 경우만 연장버튼 활성화
                        onPressed: context.watch<MyFoodDetailViewModel>().isOld
                            ? () {
                                showDialog(
                                    context: context,
                                    builder: (desContext) {
                                      return TwoAnswerDialog(
                                          title: '연장하시겠습니까?',
                                          subtitle: '연장은 1회만 가능합니다.',
                                          firstButton: '네',
                                          secondButton: '아니오',
                                          onTap: () {
                                            //'네'클릭 -> 남은 날 2일 이상으로 변경, 연장버튼 비활성화
                                            viewModel.isOld = false;
                                            viewModel.extendPeriod(
                                                widget.myFoodItem,
                                                widget.ourRefrigItem);
                                            viewModel.updateFirestore(
                                                widget.myFoodItem);
                                            Navigator.of(context).pop();
                                          });
                                    });
                              }
                            //연장버튼 비활성화
                            : null,
                        child: Text('연장하기',
                            style: AppTextStyle.body14R(
                                color: Colors.grey.shade100)),
                      ),
                    ),
              SizedBox(height: 6.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r)),
                      backgroundColor: const Color(0xFFcb7d74)),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (desContext) {
                          return NoTwoAnswerDialog(
                            title: '삭제하시겠습니까?',
                            subtitle: '삭제 후 복구가 불가합니다.',
                            firstButton: '네',
                            secondButton: '아니오',
                            onTap: () {
                              //'네' 클릭 -> firebase, storage 삭제
                              viewModel.deleteFoodAndStorage(
                                  widget.myFoodItem, widget.ourRefrigItem);
                              Navigator.of(context).pop();
                              if (mounted) {
                                context.go('/main_page', extra: 1);
                              }
                            },
                          );
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
