import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/mock_repository/refrige_repository.dart';
import 'package:leute/styles/app_text_style.dart';

import '../../../data/models/refrige_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> fridges = [];
  List<RefrigeDetail> refrigeItems = [];

  @override
  void initState() {
    refrigeItems = RegisterdRefrigeRepository().getRefrigeDetail();

    for (int i = 1; i <= refrigeItems.length; i++) {
      fridges.add(makeFridge(i-1));
    }

    super.initState();
  }

  Widget makeFridge(int index) {
    return GestureDetector(
      onTap: () => context.go('/details', extra: refrigeItems[index]),
      child: Container(
        width: 100,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              blurRadius: 2.0,
            ),
          ],
        ),
        child: Center(
          child: Text(
            refrigeItems[index].refrigeName,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black12,
          title: Center(
            child: Text(
              '냉장고',
              style: AppTextStyle.header20(),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 30,
                crossAxisSpacing: 30,
                childAspectRatio: 4 / 6),
            itemCount: fridges.length + 1,
            itemBuilder: (context, index) {
              if (index == fridges.length) {
                // Last item is the add button
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    fridges.add(makeFridge(index + 1));
                    setState(() {});
                  },
                );
              } else {
                // Display the fridge container
                return fridges[index];
              }
            },
          ),
        ),
      ),
    );
  }
}
