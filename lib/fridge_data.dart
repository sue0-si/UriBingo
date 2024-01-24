import 'package:cloud_firestore/cloud_firestore.dart'; // new
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class FridgeState extends ChangeNotifier {
  Future addInfo() {
    return FirebaseFirestore.instance.collection('foodDetails').add(<String, dynamic> {
      'foodImage': 'https://images.unsplash.com/photo-1621855046181-29ce1e3d70a4?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'freezed': true,
      'isPublic': false,
      'isUnknown': false,
      'positionId': 1,
      'refridgeId': 1,
      'registerDate': DateTime.now().millisecondsSinceEpoch,
      'remainPeriod': 7,
      'userId': '3',  // FirebaseAuth.instance.currentUser!.uid,
      'userName': '아이유'  // FirebaseAuth.instance.currentUser!.displayName,

    });
  }
}