import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';

import '../../../data/models/refrige_model.dart';
import '../../../data/repository/refrige_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> fridges = [];
  List<RefrigeDetail> refrigeItems = [];

  bool isManager = false;

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    refrigeItems = await RegisterdRefrigeRepository().getFirebaseRefrigesData();
    setState(() {
      refrigeItems;
    });
    for (int i = 1; i <= refrigeItems.length; i++) {
      fridges.add(makeFridge(i - 1));
    }
  }

  Widget makeFridge(int index) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => context.go('/details', extra: refrigeItems[index]),
          child: Container(
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
        ),
        //관리자 버튼
        isManager
            ? ElevatedButton(onPressed: () {}, child: Text('수정'))
            : Container()
      ],
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
              childAspectRatio: 3 / 6,
            ),
            itemCount: fridges.length + 1,
            itemBuilder: (context, index) {
              if (index == fridges.length) {
                // Last item is the add button
                return isManager
                    ? IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          context.push('/addRefrige');
                          setState(() {});
                        },
                      )
                    : Container();
              } else {
                // Display the fridge container
                return fridges[index];
              }
            },
          ),
        ),
        //-----------------------------------------예시
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              isManager = !isManager;
            });
            print(isManager);
          },
          child: Icon(Icons.toggle_on),
        ),
        //-----------------------------------------
      ),
    );
  }
}
