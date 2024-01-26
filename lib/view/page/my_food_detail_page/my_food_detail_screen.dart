import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import '../../../data/repository/foods_repository.dart';

class MyFoodDetail extends StatefulWidget {
  const MyFoodDetail(
      {super.key, required this.myFoodItem, required this.ourRefrigItem});

  final FoodDetail myFoodItem;
  final RefrigeDetail ourRefrigItem;

  @override
  State<MyFoodDetail> createState() => _MyFoodDetailState();
}

class _MyFoodDetailState extends State<MyFoodDetail> {
  final myFoodViewModel = MyFoodDetailViewModel();
  int _remainPeriod = 0;
  bool _isOld = false;

  // 앱 실행시 initData
  // 남은기간 계산 후 연장버튼 네 클릭 시 _remainPeriod 업데이트
  // 음식이 오래됐는지 체크 후 _isOld 업데이트
  @override
  void initState() {
    initData();
    super.initState();
    _remainPeriod = myFoodViewModel.calculateRemainPeriod(
        widget.myFoodItem, widget.ourRefrigItem);
    _isOld = myFoodViewModel.checkOld(widget.myFoodItem, widget.ourRefrigItem);
  }

  //foodDetails 데이터 get
  void initData() async {
    final foods = await RegisterdFoodsRepository().getFirebaseFoodsData();
    setState(() {
      foods;
    });
  }

  Widget build(BuildContext context) {
    final dateFormat = DateFormat('yyyy년 MM월 dd일');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/', extra: 1);
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
                    '$_remainPeriod일',
                    style: AppTextStyle.body14R(
                        color: _isOld
                            ? AppColors.caution
                            : AppColors.mainText),
                  ),
                  const Spacer(),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50]),
                    //남은 기간이 2일 미만일 경우 _isOld true -> 버튼 활성화 -> 다이얼로그 생성 / 2일 이상일 경우 버튼 비활성화
                    onPressed:_isOld
                        ? () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return TwoAnswerDialog(
                                      title: '연장하시겠습니까?',
                                      firstButton: '네',
                                      secondButton: '아니오',
                                      onTap: () {
                                        //'네' 클릭 후 _isOld false로 업데이트 ->연장버튼 비활성화처리, 연장된 기간으로 _remainPeriod 업데이트, firestore isExtended 값 true로 변경
                                        setState(() {
                                         _isOld =
                                              false;
                                          _remainPeriod =
                                              myFoodViewModel.extendPeriod(
                                                  widget.myFoodItem,
                                                  widget.ourRefrigItem);
                                         myFoodViewModel.updateFirestore(widget.myFoodItem);
                                        });
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
                            builder: (context) {
                              return TwoAnswerDialog(
                                  title: '등록한 음식을 삭제하시겠습니까?',
                                  firstButton: '네',
                                  secondButton: '아니오',
                                  // 네 버튼 클릭 후 firebase 해당 doc삭제, firestorage 해당 이미지 삭제
                                  onTap: () {
                                    myFoodViewModel.deleteFoodAndStorage(widget.myFoodItem, widget.ourRefrigItem);
                                    // dialog 종료 후 메인페이지로 이동
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
              //남은 기간에 따라 다른 텍스트 출력 (2일 미만 "곧 폐기" 2일 이상 "연장불가)
              _isOld
                  ? Text('곧 폐기됩니다.',
                      style: AppTextStyle.body14R(color: AppColors.caution))
                  :  widget.myFoodItem.isExtended ? const Text('더이상 연장이 불가해요')
                  : const Text('아직은 연장이 불가해요')
            ],
          ),
        ),
      ]),
    );
  }
}
