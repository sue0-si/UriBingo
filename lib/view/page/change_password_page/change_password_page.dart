import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_buttons/custom_button.dart';
import 'package:leute/view/widget/custom_dialog/one_answer_dialog.dart';
import 'package:provider/provider.dart';

import '../../widget/login_widget/password_textfield.dart';
import '../login_page/login_page_view_model.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _currentPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginPageViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.go('/main_page', extra: 2);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 250.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '비밀번호 변경',
                style: AppTextStyle.header22(),
              ),
              Form(
                key: _formKey2,
                child: PasswordTextfield(
                  hintText: '현재 비밀번호',
                  controller: _currentPasswordController,
                  validator: viewModel.passwordValidator,
                ),
              ),
              Form(
                key: _formKey,
                child: PasswordTextfield(
                  hintText: '새로운 비밀번호',
                  controller: _newPasswordController,
                  validator: viewModel.passwordValidator,
                ),
              ),
              CustomButton(
                  width: 100.w,
                  height: 30.h,
                  backgroundColor: const Color(0xFF9bc6bf),
                  textStyle: AppTextStyle.body14R(color: Colors.white),
                  text: '변경하기',
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final cred = EmailAuthProvider.credential(
                          email: currentUser.email!,
                          password: _currentPasswordController.text);

                      currentUser
                          .reauthenticateWithCredential(cred)
                          .then((value) async {
                        await currentUser
                            .updatePassword(_newPasswordController.text);
                        if (mounted) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return OneAnswerDialog(
                                  onTap: () async {
                                    await FirebaseAuth.instance.signOut();
                                    if (mounted) {
                                      context.go('/login');
                                    }
                                  },
                                  title: '정상 변경되었습니다.',
                                  firstButton: '확인',
                                  subtitle: '새로운 비밀번호로 로그인 해주세요.',
                                );
                              });
                        }
                      }).catchError((error) {
                        if (error is FirebaseAuthException) {
                          if (error.code == 'requires-recent-login') {
                            OneAnswerDialog(
                              onTap: () async {
                                await FirebaseAuth.instance.signOut();
                                if (mounted) {
                                  context.go('/login');
                                }
                              },
                              title: '로그인 세션이 만료되었습니다.',
                              firstButton: '확인',
                              subtitle: '다시 로그인 해주세요.',
                            );
                          } else if (error.code == 'invalid-credential') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('입력하신 현재 비밀번호가 틀렸습니다.'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('인증 오류가 발생했습니다. 잠시후 다시 시도해주세요.'),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('오류가 발생했습니다. 잠시후 다시 시도해주세요.'),
                            ),
                          );
                        }
                      });
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
