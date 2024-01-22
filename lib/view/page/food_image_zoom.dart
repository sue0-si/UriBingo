import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FoodImageZoom extends StatelessWidget {
  const FoodImageZoom({super.key, required this.itemImage});

  final String itemImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading:  IconButton(icon: const Icon(Icons.arrow_back),
            onPressed: () {
context.go('/');
            },
          ),
        ),
        body: Hero(
          tag: 'image',
          child: Image.asset(itemImage),
        ));
  }
}
