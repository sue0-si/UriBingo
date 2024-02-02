import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view/widget/custom_dialog/one_answer_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_model.dart';
import '../data/repository/user_data_repository.dart';

class LoginPageViewModel with ChangeNotifier {
  final UserDataRepository userDataRepository = UserDataRepository();
  UserModel? currentUser;
  bool checkBoxMemory = false;
  String idMemory = '';
  SharedPreferences? prefs;

  LoginPageViewModel() {
    initPreferences();
  }
  // 로그인
  Future<void> handleLoginButton(
      {required String email,
      required String password,
      required BuildContext context}) async {
    // 로그인하고 메인페이지 이동
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (context.mounted) {
        prefs!.setString('_email', email);
        context.go('/main_page', extra: 0);
      }
      // 로그인 실패시 다이얼로그
    } on FirebaseAuthException catch (_) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return OneAnswerDialog(
                onTap: () {
                  Navigator.pop(context);
                },
                title: '로그인 실패',
                subtitle: '존재하지 않는 아이디 혹은 비밀번호가 일치하지 않습니다.',
                firstButton: '확인');
          },
        );
      }
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

// 체크박스 저장
  checkBox(value) {
    checkBoxMemory = value;
    if (prefs != null) {
      prefs!.setBool('_checkBox', value);
    }
    notifyListeners();
  }

// 아이디 불러오기 체크박스 불러오기
  Future<String> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      checkBoxMemory = prefs!.getBool('_checkBox') ?? false;
      if (checkBoxMemory) {
        idMemory = prefs!.getString('_email') ?? '';
        notifyListeners();
        return idMemory;
      }
    }
    notifyListeners();
    return '';
  }

// 비밀번호 찾기 페이지 이동
  goToPasswordResetPage(BuildContext context) {
    context.go('/passwordReset');
  }

// 비밀번호 재설정 이메일 전송
  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}