import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> fridges = [];

  Widget makeFridge(int index) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(
          '${index+1}번 냉장고',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('공용 냉장고'),
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
                  fridges.add(makeFridge(index));
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
    );
  }
}
