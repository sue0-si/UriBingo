import 'package:flutter/material.dart';

class FoodDetailImageWidget extends StatelessWidget {
  final String itemImage;

  const FoodDetailImageWidget({
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