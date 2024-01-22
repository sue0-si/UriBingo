import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> fridges = [];

  Widget makeFridge() {
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
      child: Center(
        child: Text(
          '1번 냉장고',
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
          ...fridges,
          IconButton(
            onPressed: () {
              setState(() {
                fridges.add(makeFridge());
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
