import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_widget/login_elevated_button.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';
import 'package:leute/view/widget/login_widget/password_textfield.dart';
import 'package:leute/view_model/signup_page_view_model.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  final String userToken;
  const SignupPage({super.key, required this.userToken});

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
        padding: const EdgeInsets.all(8.0),
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
                    SizedBox(width: 8.w),
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
                    SizedBox(width: 8.w),
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
                SizedBox(height: 8.h),
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
