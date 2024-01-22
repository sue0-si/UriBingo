import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../refrige_detail/data/mock_repository/refrige_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> sliverList = [];

  @override
  void initState() {
    final refrigeItems = RegisterdRefrigeRepository()
        .getRefrigeDetail();

    for (int i = 1; i <= refrigeItems.length; i++) {

      sliverList
          .add(makeFridge(refrigeItems[i-1].refrigeId));
    }

    super.initState();
  }

  Widget makeFridge(int refrigeNum) {
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: GestureDetector(
        onTap: () => context.go('/details', extra: refrigeNum),
        child: Center(
          child: Text(
            '$refrigeNum번 냉장고',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('공용 냉장고')),
      ),
      body: Row(
        children: [
          ...sliverList,
          IconButton(
            onPressed: () {
              setState(() {
                sliverList.add(makeFridge(sliverList.length+1));
              });
            },
            icon: Icon(
              Icons.add,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
