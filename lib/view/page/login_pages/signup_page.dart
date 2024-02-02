import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_widget/login_elevated_button.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';
import 'package:leute/view/widget/login_widget/password_textfield.dart';
import 'package:leute/view_model/signup_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_dialog/two_answer_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var employeeNumberController = TextEditingController();
  var groupNameController = TextEditingController();
  var validationCodeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    employeeNumberController.dispose();
    groupNameController.dispose();
    validationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignupPageViewModel>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Text('이메일', style: AppTextStyle.body16B()),
                LoginTextfield(
                  hintText: 'email@email.com',
                  controller: emailController,
                  validator: viewModel.emailValidator,
                ),
                SizedBox(height: 8.h),
                Text('비밀번호', style: AppTextStyle.body16B()),
                PasswordTextfield(
                  hintText: '******',
                  controller: passwordController,
                  validator: viewModel.passwordValidator,
                ),
                SizedBox(height: 8.h),
                Text('비밀번호 확인', style: AppTextStyle.body16B()),
                PasswordTextfield(
                  hintText: '******',
                  controller: confirmPasswordController,
                  validator: viewModel.confirmPasswordValidator,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('이름', style: AppTextStyle.body16B()),
                          LoginTextfield(
                            hintText: '홍길동',
                            controller: nameController,
                            validator: viewModel.nameValidator,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('멤버번호', style: AppTextStyle.body16B()),
                          LoginTextfield(
                            hintText: '123456',
                            controller: employeeNumberController,
                            validator: viewModel.employeeNumberValidator,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('그룹명', style: AppTextStyle.body16B()),
                          LoginTextfield(
                            hintText: 'ㅇㅇ그룹',
                            controller: groupNameController,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('그룹고유번호', style: AppTextStyle.body16B()),
                          LoginTextfield(
                            hintText: '123456',
                            controller: validationCodeController,
                            validator: viewModel.validationCodeValidator,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                LoginElevatedButton(
                    childText: '가입하기',
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        await viewModel.handleSignUp(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            name: nameController.text,
                            employeeNumber: employeeNumberController.text,
                            groupName: groupNameController.text,
                            validationCode: validationCodeController.text);

                        // 그룹 고유번호가 이미 존재할 경우 - 그 그룹의 사용자로 등록함
                        if (viewModel.isValidationCodeInUse) {
                          if (mounted) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TwoAnswerDialog(
                                  title: '그룹명: ${viewModel.usingGroupName}',
                                  subtitle: '사용자로 등록됩니다.',
                                  firstButton: '확인',
                                  secondButton: '취소',
                                  onTap: () async {
                                    // Firebase에 회원가입 요청(사용자)
                                    await viewModel.postNewMemberData(
                                        emailController.text,
                                        passwordController.text,
                                        nameController.text,
                                        employeeNumberController.text,
                                        groupNameController.text,
                                        validationCodeController.text,
                                        false);
                                    // 가입 성공 시 메인 페이지로 이동
                                    if (mounted) {
                                      context.go('/main_page', extra: 0);
                                    }
                                  },
                                );
                              },
                            );
                          }
                        } else {
                          // 그룹 고유번호가 없는 경우 - 신규로 생성하고 관리자로 등록함
                          if (mounted) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TwoAnswerDialog(
                                  title: '신규 생성될 고유번호',
                                  subtitle:
                                      '그룹명: ${groupNameController.text}의 관리자로 등록됩니다.',
                                  firstButton: '확인',
                                  secondButton: '취소',
                                  onTap: () async {
                                    // Firebase에 회원가입 요청(관리자)
                                    await viewModel.postNewMemberData(
                                        emailController.text,
                                        passwordController.text,
                                        nameController.text,
                                        employeeNumberController.text,
                                        groupNameController.text,
                                        validationCodeController.text,
                                        true);
                                    // 가입 성공 시 메인 페이지로 이동
                                    if (mounted) {
                                      context.go('/main_page', extra: 0);
                                    }
                                  },
                                );
                              },
                            );
                          }
                        }
                      }
                    }),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text('이미 계정이 있습니까?'),
                  TextButton(
                      onPressed: () {
                        context.push(Uri(path: '/login').toString());
                      },
                      child: const Text('로그인하기'))
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
