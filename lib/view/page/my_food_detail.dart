import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'food_image_zoom.dart';


class MyFoodDetail extends StatefulWidget {
  final String registerDate;
  final int remainPeriod;
  final String itemImage;

  const MyFoodDetail({
    super.key,
    required this.registerDate,
    required this.remainPeriod,
    required this.itemImage,
  });

  @override
  State<MyFoodDetail> createState() => _MyFoodDetailState();
}

class _MyFoodDetailState extends State<MyFoodDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const Icon(Icons.arrow_back)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              context.go('/foodimagezoom');
            },
            child: Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: widget.itemImage.isNotEmpty
                    ? AssetImage(widget.itemImage)
                  : const AssetImage('assets/images/default_image.jpeg'),
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Container(
              height: 250,
              width: 300,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('등록일 : ${widget.registerDate}'),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('남은기간: ${widget.remainPeriod}일'),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('연장하기'))
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
