import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPageViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // 회원가입
  Future<void> handleSignUp({
    required String email,
    required String password,
    required String confirmPassword,
    required String name,
    required String employeeNumber,
  }) async {
    try {
      // 비밀번호 확인
      if (password != confirmPassword) {
        throw Exception('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
      }

      // Firebase에 회원가입 요청
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 추가 정보 처리
      await _firestore.collection('profile').doc(userCredential.user!.uid).set({
        'name': name,
        'employeeNumber': employeeNumber,
      });
    } catch (error) {
      // ignore: avoid_print
      print('Error during signup: $error');
    }
  }
}
