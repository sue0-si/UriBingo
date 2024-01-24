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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    nameController.dispose();
    employeeNumberController.dispose();
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
                  hintText: '****',
                  controller: passwordController,
                  validator: viewModel.passwordValidator,
                ),
                SizedBox(height: 8.h),
                Text('비밀번호 확인', style: AppTextStyle.body16B()),
                PasswordTextfield(
                  hintText: '****',
                  controller: confirmPasswordController,
                  validator: viewModel.confirmPasswordValidator,
                ),
                SizedBox(height: 8.h),
                Text('이름', style: AppTextStyle.body16B()),
                LoginTextfield(
                  hintText: '홍길동',
                  controller: nameController,
                  validator: viewModel.nameValidator,
                ),
                SizedBox(height: 8.h),
                Text('사원번호', style: AppTextStyle.body16B()),
                LoginTextfield(
                  hintText: '12-3456',
                  controller: employeeNumberController,
                  validator: viewModel.employeeNumberValidator,
                ),
                SizedBox(height: 8.h),
                LoginElevatedButton(
                    childText: '가입하기',
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        viewModel.handleSignUp(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text,
                            confirmPassword: confirmPasswordController.text,
                            name: nameController.text,
                            employeeNumber: employeeNumberController.text);
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
