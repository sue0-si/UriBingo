import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view_model/my_page_view_model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyPageViewModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            '내정보',
            style: AppTextStyle.header28(color: AppColors.mainText),
          ),
          ElevatedButton(
              onPressed: () {
                viewModel.signOut(context: context);
              },
              child: Text('로그아웃')),
        ],
      ),
    );
  }
}
