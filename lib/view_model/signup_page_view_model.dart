import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view/widget/custom_dialog/one_answer_dialog.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';

import '../data/models/user_model.dart';
import '../data/repository/user_data_repository_impl.dart';
import '../domain/user_data_repository.dart';

class SignupPageViewModel with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UserDataRepository userDataRepository = UserDataRepositoryImpl();
  UserModel? currentUser;
  bool isLoading = false;
  bool _disposed = false;
  bool isValidationCodeInUse = false;
  String usingGroupName = '';

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

  // 회원가입
  Future<void> handleSignUp(
      {required String email,
      required String password,
      required String confirmPassword,
      required String name,
      required String employeeNumber,
      required String groupName,
      required String validationCode,
      required BuildContext context}) async {
    // 이메일 중복 검사
    bool isEmailInUse = await checkIfEmailInUse(email);
    // 그룹고유번호 중복 검사
    final checkInUse =
        await checkIfValidationCodeInUse(validationCode, groupName);
    notifyListeners();
    isValidationCodeInUse = checkInUse[0];
    usingGroupName = checkInUse[1];

    // 중복된 이메일 및 중복 그룹고유번호 처리
    if (context.mounted) {
      if (isEmailInUse) {
        showDialog(
          context: context,
          builder: (context) {
            return OneAnswerDialog(
                onTap: () {
                  Navigator.pop(context);
                },
                title: '회원가입 실패',
                subtitle: '해당 이메일은 이미 사용 중입니다.',
                firstButton: '확인');
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
            return OneAnswerDialog(
              onTap: () {
                Navigator.pop(context);
              },
              title: '오류',
              subtitle: '비밀번호와 비밀번호 확인이 일치하지 않습니다.',
              firstButton: '확인',
            );
          },
        );
        return;
      }
    }

    // 그룹 고유번호가 이미 존재할 경우 - 그 그룹의 사용자로 등록함
    if (isValidationCodeInUse) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return TwoAnswerDialog(
              title: '그룹명: $usingGroupName',
              subtitle: '사용자로 등록됩니다.',
              firstButton: '확인',
              secondButton: '취소',
              onTap: () async {
                // Firebase에 회원가입 요청(사용자)
                await postNewMemberData(email, password, name, employeeNumber,
                    usingGroupName, validationCode, false);
                // 가입 성공 시 메인 페이지로 이동
                if (context.mounted) {
                  context.go('/main_page', extra: 0);
                }
              },
            );
          },
        );
      }
    } else {
      // 그룹 고유번호가 없는 경우 - 신규로 생성하고 관리자로 등록함
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) {
            return TwoAnswerDialog(
              title: '신규 생성될 고유번호',
              subtitle: '그룹명: $groupName의 관리자로 등록됩니다.',
              firstButton: '확인',
              secondButton: '취소',
              onTap: () async {
                // Firebase에 회원가입 요청(관리자)
                await postNewMemberData(email, password, name, employeeNumber,
                    groupName, validationCode, true);
                // 가입 성공 시 메인 페이지로 이동
                if (context.mounted) {
                  context.go('/main_page', extra: 0);
                }
              },
            );
          },
        );
      }
    }

    notifyListeners();
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

  // 그룹 고유번호, 그룹명 중복검사
  Future<List<dynamic>> checkIfValidationCodeInUse(
      String validationCode, String groupName) async {
    QuerySnapshot<Map<String, dynamic>> query = await _firestore
        .collection('profile')
        .where('validationCode', isEqualTo: validationCode)
        .get();
    if (query.size > 0) {
      return [query.docs.isNotEmpty, query.docs.first.data()['groupName']];
    }
    // 이미 사용 중
    else {
      return [false, groupName];
    }
  }

// 신규 유저 Firebase 등록 요청 메서드
  Future<void> postNewMemberData(
      String email,
      String password,
      String name,
      String employeeNumber,
      String groupName,
      String validationCode,
      bool isManager) async {
    // Firebase에 회원가입 요청
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // displayname에 이름 추가
    await userCredential.user?.updateDisplayName(name);
    // 추가 정보 처리
    await _firestore.collection('profile').doc(userCredential.user!.uid).set({
      'userId': userCredential.user!.uid,
      'name': name,
      'employeeNumber': employeeNumber,
      'manager': isManager,
      'email': email,
      'groupName': groupName,
      'validationCode': validationCode,
    });
    notifyListeners();
  }

  // 신규 유저 확인용 요청 메서드
  Future<void> getNewMemberData() async {
    isLoading = true;
    notifyListeners();
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    currentUser = userData.firstWhere(
        (user) => user.email == FirebaseAuth.instance.currentUser?.email);

    isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
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
    // if (value == null || value.isEmpty) {
    //   return '사원번호를 입력하세요.';
    // }
    return null;
  }

  // 그룹 고유번호 유효성 검사
  String? validationCodeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return '그룹 고유번호를 입력하세요.';
    }
    return null;
  }
}
