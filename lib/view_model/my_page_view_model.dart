// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MyPageViewModel with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool manager = false;
  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  MyPageViewModel() {
    fetchManagerData();
  }

  // 매니저여부 가져오기
  Future<void> fetchManagerData() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await fireStore.collection('profile').doc(user?.uid).get();
    manager = doc['manager'];
    notifyListeners();
  }

  // 로그아웃
  signOut({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      context.go('/login');
    }
  }

  // 그룹 관리페이지로 이동
  goToGroupSettingPage(BuildContext context) {
    context.push('/groupSetting');
  }

  // 회원탈퇴
  Future<void> deleteAccount(BuildContext context, userid) async {
    FirebaseFirestore.instance.collection('profile').doc(userid).delete();
    await user!.delete();
    if (context.mounted) {
      context.go('/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('회원탈퇴 완료'),
        ),
      );
    }
  }
}
