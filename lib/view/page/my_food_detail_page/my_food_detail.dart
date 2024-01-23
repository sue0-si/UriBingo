import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';
import 'package:leute/data/mock_repository/foods_repository.dart';
import 'package:leute/data/mock_repository/refrige_repository.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';

class MyFoodDetail extends StatefulWidget {
  const MyFoodDetail({super.key});

  @override
  State<MyFoodDetail> createState() => _MyFoodDetailState();
}

class _MyFoodDetailState extends State<MyFoodDetail> {
  @override
  final foodRepository = RegisterdFoodsRepository();
  final refrigeRepository = RegisterdRefrigeRepository();
  bool isEnabled = true;
  int extendedPeriod = 0;

  bool checkRemainPeriod() {
    return foodRepository.foods[3].remainPeriod < 2;
  }

  void extendPeriod() {
    extendedPeriod = foodRepository.foods[0].remainPeriod +
        refrigeRepository.refriges[0].extentionPeriod;
    setState(() {});
  }

  @override
  void initState() {
    checkRemainPeriod();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImage(
                  itemImage: foodRepository.foods[0].foodImage,
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
                child: Image.network(foodRepository.foods[0].foodImage,
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
                  Text('등록일: ${foodRepository.foods[3].registerDate}',
                      style: AppTextStyle.body14R()),
                ],
              ),
              Row(
                children: [
                  Text('남은기간: ', style: AppTextStyle.body14R()),
                  isEnabled
                      ? Text(
                          '${foodRepository.foods[0].remainPeriod}일',
                          style: AppTextStyle.body14R(
                              color: checkRemainPeriod()
                                  ? AppColors.caution
                                  : AppColors.mainText),
                        )
                      : Text(
                          '$extendedPeriod일',
                          style: AppTextStyle.body14R(
                              color: checkRemainPeriod()
                                  ? AppColors.caution
                                  : AppColors.mainText),
                        ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[50]),
                    onPressed: isEnabled
                        ? () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return TwoAnswerDialog(
                                      title: '연장하시겠습니까?',
                                      firstButton: '네',
                                      secondButton: '아니오',
                                      onTap: () {
                                        setState(() {
                                          isEnabled = false;
                                          extendPeriod();
                                        });
                                        Navigator.of(context).pop();
                                      });
                                });
                          }
                        : null,
                    child: const Text('연장하기'),
                  )
                ],
              ),
              SizedBox(height: 32.h),
              checkRemainPeriod()
                  ? Text('곧 폐기됩니다.',
                      style: AppTextStyle.body14R(color: AppColors.caution))
                  : const Text(''),
            ],
          ),
        ),
      ]),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String itemImage;

  const FullScreenImage({
    super.key,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: 'imageTag',
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: Image.network(itemImage, fit: BoxFit.contain),
            ),
          ),
        ),
      ),
    );
  }
}
