import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_buttons/custom_button.dart';
import 'package:leute/view/widget/custom_dialog/one_answer_dialog.dart';
import 'package:provider/provider.dart';
import 'login_page_view_model.dart';
import '../../widget/login_widget/password_textfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _newPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginPageViewModel>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 200.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '비밀번호 변경',
                style: AppTextStyle.header22(),
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
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    FirebaseAuth.instance.currentUser
                        ?.updatePassword(_newPasswordController.text);
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
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
