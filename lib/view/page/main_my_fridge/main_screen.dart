import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view_model/main_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';

import '../../../data/models/refrige_model.dart';
import '../../../data/repository/refrige_repository.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
//   List<Widget> fridges = [];
//   List<RefrigeDetail> refrigeItems = [];
//
//   final UserDataRepository userDataRepository = UserDataRepository();
//   bool isManager = false;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainScreenViewModel>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Center(
            child: Text(
              '냉장고',
              style: AppTextStyle.header20(color: Colors.white),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: Color(0xFF254e7a),
                borderRadius: BorderRadius.circular(10)),
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
            itemCount: viewModel.fridges.length + 1,
            itemBuilder: (context, index) {
              if (index == viewModel.fridges.length) {
                // Last item is the add button
                return viewModel.isManager
                    ? IconButton(
                        icon: Icon(UniconsLine.plus_square, size: 40),
                        onPressed: () {
                          context.go('/addRefrige', extra: 0);

                          setState(() {});
                        },
                      )
                    : Container();
              } else {
                // Display the fridge container
                return viewModel.fridges[index];
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
