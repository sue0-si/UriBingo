import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel with ChangeNotifier {
  handleLoginButton(String email, String password) async {
    var res = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print(res);
  }
}
