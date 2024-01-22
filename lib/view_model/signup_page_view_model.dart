import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPageViewModel with ChangeNotifier {
  // 회원가입
  handleSignUp() {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: '', password: '');
  }
}
