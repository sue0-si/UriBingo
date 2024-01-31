import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;

  const PasswordTextfield(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validator});

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  String textFormFieldText = '';
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
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
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText
                      ? Image.asset(
                          'assets/images/closed_eyes.png',
                          width: 24.w,
                          height: 24.h,
                          color: AppColors.info,
                        )
                      : const Icon(
                          Icons.remove_red_eye,
                          color: AppColors.mainButton,
                        ))
              : Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: obscureText
                              ? Image.asset(
                                  'assets/images/closed_eyes.png',
                                  width: 24.w,
                                  height: 24.h,
                                  color: AppColors.info,
                                )
                              : const Icon(
                                  Icons.remove_red_eye,
                                  color: AppColors.mainButton,
                                )),
                      GestureDetector(
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
                      ),
                    ],
                  ),
                )),
    );
  }
}
