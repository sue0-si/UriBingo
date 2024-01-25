import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/user_model.dart';
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

  final UserDataRepository userDataRepository = UserDataRepository();
  bool isManager = true;

  @override
  void initState() {
    initData();
    super.initState();

  }

  void initData() async {//비동기로 변경
    refrigeItems = await RegisterdRefrigeRepository().getFirebaseRefrigesData();
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    UserModel currentUser = userData.firstWhere(
        (user) => user.email == FirebaseAuth.instance.currentUser!.email);
    setState(() {
      refrigeItems;
      isManager = currentUser.manager;
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
            ? ElevatedButton(
                onPressed: () {
                  context.go('/editRefrige', extra: refrigeItems[index]);
                },
                child: Text('수정'))
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
                          context.go('/addRefrige');


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
      ),
    );
  }
}

class UserDataRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getFirebaseUserData() async {
    // Firebase Firestore에서 데이터 읽어오기
    QuerySnapshot querySnapshot = await _firestore.collection('profile').get();

    // 데이터 파싱
    List<UserModel> data = [];
    querySnapshot.docs.forEach((DocumentSnapshot document) {
      data.add(UserModel.fromJson(document.data() as Map<String, dynamic>));
    });
    return data;
  }
}
