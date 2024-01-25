import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignupPageViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // 회원가입
  Future<void> handleSignUp(
      {required String email,
      required String password,
      required String confirmPassword,
      required String name,
      required String employeeNumber,
      required BuildContext context}) async {
    // 이메일 중복 검사
    bool isEmailInUse = await checkIfEmailInUse(email);

    // 중복된 이메일 처리
    if (context.mounted) {
      if (isEmailInUse) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('오류'),
              content: const Text('해당 이메일은 이미 사용 중입니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
        return;
      }
    }

    // 비밀번호 확인
    if (context.mounted) {
      if (password != confirmPassword) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('오류'),
              content: const Text('비밀번호와 비밀번호 확인이 일치하지 않습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    }
    // Firebase에 회원가입 요청
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // displayname에 이름 추가
    await userCredential.user?.updateDisplayName(name);
    // 추가 정보 처리
    await _firestore.collection('profile').doc(userCredential.user!.uid).set({
      'name': name,
      'employeeNumber': employeeNumber,
      'manager': false,
      'email': email
    });
    // 가입 성공 시 메인 페이지로 이동
    if (context.mounted) {
      context.go('/');
    }
  }

  // 이메일 중복 검사
  Future<bool> checkIfEmailInUse(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> query = await _firestore
          .collection('profile')
          .where('email', isEqualTo: email)
          .get();
      return query.docs.isNotEmpty; // 이미 사용 중
    } catch (e) {
      // ignore: avoid_print
      print('에러: $e');
      return false;
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
