import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageViewModel with ChangeNotifier {
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
        context.go('/', extra: 0);
      }
      // 로그인 실패시 다이얼로그
    } on FirebaseAuthException catch (_) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('오류'),
              content: const Text('존재하지 않는 아이디 혹은 비밀번호가 일치하지 않습니다.'),
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
  void initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs != null) {
      checkBoxMemory = prefs!.getBool('_checkBox') ?? false;
      if (checkBoxMemory) {
        idMemory = prefs!.getString('_email') ?? '';
      }
      notifyListeners();
    }
  }
}
