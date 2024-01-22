import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:leute/custom_dialog/first_custom_dialog.dart';
import 'package:leute/refrige_detail/data/mock_repository/foods_repository.dart';
import 'package:leute/styles/app_text_style.dart';

class MyFoodDetail extends StatefulWidget {
  const MyFoodDetail({super.key});

  @override
  State<MyFoodDetail> createState() => _MyFoodDetailState();
}

class _MyFoodDetailState extends State<MyFoodDetail> {

  @override
  final presentDate = DateFormat("yyy년 MM월 dd일").format(DateTime.now());
  final repository = RegisterdFoodsRepository();



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
                  itemImage: repository.foods[0].foodImage,
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
                child: Image.network(repository.foods[0].foodImage, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 32),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text('등록일: ${repository.foods[0].registerDate}',
                      style: AppTextStyle.body14R()),
                ],
              ),
              Row(
                children: [
                  Text('남은기간: ${repository.foods[0].remainPeriod}일',
                      style: AppTextStyle.body14R()),
                  const Spacer(),
                  ElevatedButton(onPressed: () {
                    showDialog(context: context, builder: (context) {
                      return FirstCustomDialog();
                    });
                  }, child: const Text('연장하기'))
                ],
              ),
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
