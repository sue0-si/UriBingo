import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_dialog/one_answer_dialog.dart';
import 'package:leute/view/widget/login_widget/login_elevated_button.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';
import 'package:leute/view_model/login_page_view_model.dart';
import 'package:provider/provider.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  var emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<LoginPageViewModel>();
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: _formKey,
                child: Center(
                    child: ListView(shrinkWrap: true, children: [
                  Text('비밀번호 재설정 이메일', style: AppTextStyle.body16B()),
                  LoginTextfield(
                    hintText: 'email@email.com',
                    controller: emailController,
                    validator: viewModel.emailValidator,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  LoginElevatedButton(
                      childText: '이메일 전송',
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          try {
                            await viewModel
                                .sendPasswordResetEmail(emailController.text);
                            if (context.mounted) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return OneAnswerDialog(
                                        onTap: () {
                                          context.go('/login');
                                        },
                                        title: '전송 완료',
                                        subtitle:
                                            '${emailController.text}로\n비밀번호 재설정 이메일이 전송되었습니다.',
                                        firstButton: '확인');
                                  });
                            }
                          } catch (e) {
                            if (context.mounted) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return OneAnswerDialog(
                                        onTap: () {
                                          context.pop();
                                        },
                                        title: '$e',
                                        subtitle: '비밀번호 재설정 이메일전송을 실패하였습니다.',
                                        firstButton: '확인');
                                  });
                            }
                          }
                        }
                      }),
                  SizedBox(
                    height: 16.h,
                  ),
                  TextButton(
                      onPressed: () {
                        context.go(Uri(path: '/login').toString());
                      },
                      child: const Text('로그인 화면으로 돌아가기'))
                ])))));
  }
}
