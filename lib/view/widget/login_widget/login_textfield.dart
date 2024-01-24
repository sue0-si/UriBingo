import 'package:flutter/material.dart';
import 'package:leute/styles/app_text_colors.dart';

class LoginTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  const LoginTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator});

  @override
  State<LoginTextfield> createState() => _LoginTextfieldState();
}

class _LoginTextfieldState extends State<LoginTextfield> {
  String textFormFieldText = '';
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      onChanged: (text) {
        setState(() {
          textFormFieldText = text;
        });
      },
      maxLines: 1,
      validator: widget.validator,
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
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: AppColors.info),
          suffixIcon: textFormFieldText.isEmpty
              ? null
              : GestureDetector(
                  child: const Icon(
                    Icons.cancel,
                    color: AppColors.mainButton,
                  ),
                  onTap: () {
                    setState(() {
                      widget.controller.clear();
                      textFormFieldText = '';
                    });
                  },
                )),
    );
  }
}
