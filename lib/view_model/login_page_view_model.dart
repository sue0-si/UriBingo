import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPageViewModel with ChangeNotifier {
  handleLoginButton() async {
    var res = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: 'test@gmail.com', password: '12341234');
    print(res);
  }
}
