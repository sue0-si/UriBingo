import 'package:flutter/material.dart';
import 'package:leute/styles/app_text_colors.dart';

class LoginTextfield extends StatefulWidget {
  final String hintText;
  const LoginTextfield({super.key, required this.hintText});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  var controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: (text) {},
      keyboardType: TextInputType.text,
      maxLines: 1,
      validator: (value) {
        // 유효성 검사
        if (value == null || value.isEmpty) {
          return '입력된 값이 없을때 나오는 텍스트';
        }
        return null;
      },
      decoration: InputDecoration(
          // 기본디자인
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.mainButton,
            ),
          ),
          // 눌렀을때 디자인
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(
              width: 2,
              color: AppColors.mainButton,
            ),
          ),
          hintText: widget.hintText),
    );
  }
}
