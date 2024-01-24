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

  // 이메일 유효성 검사
  String? emailValidator(String? value) {
    final RegExp emailRegExp =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value == null || value.isEmpty) {
      return '이메일을 입력하세요.';
    }
    if (!emailRegExp.hasMatch(value)) {
      return '유효한 이메일 주소를 입력하세요.';
    }
    return null;
  }

// 비밀번호 유효성 검사
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력하세요.';
    }
    if (value.length < 6) {
      return '6자리 이상 입력하세요';
    }
    return null;
  }

// 비밀번호확인 유효성 검사
  String? confirmPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호 확인을 입력하세요.';
    }
    if (value.length < 6) {
      return '6자리 이상 입력하세요';
    }
    return null;
  }

// 이름 유효성 검사
  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '이름을 입력하세요.';
    }
    return null;
  }

// 사원번호 유효성 검사
  String? employeeNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '사원번호를 입력하세요.';
    }
    return null;
  }
}
