import 'package:flutter/material.dart';

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
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FullScreenImage(
                itemImage: widget.itemImage,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Hero(
            tag: 'imageTag',
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.asset(widget.itemImage),
            ),
          ),
        ),
      ),
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
              width: MediaQuery.of(context).size.width,
              height: 330,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                image: DecorationImage(
                  image: AssetImage(itemImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
