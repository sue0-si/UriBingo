import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyFoodImageWidget extends StatelessWidget {
  const MyFoodImageWidget({super.key, required this.itemImage});

  final String itemImage;

  @override
  Widget build(BuildContext context) {
    return Hero(
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
          child: Image.network(itemImage,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
