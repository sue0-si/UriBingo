import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';
import 'package:leute/view/widget/login_widget/Inkwell_row_tile.dart';
import 'package:leute/view/widget/login_widget/advertising_area.dart';
import 'package:leute/view_model/my_page_view_model.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyPageViewModel>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            '내정보',
            style: AppTextStyle.header22(color: Colors.white),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              color: const Color(0xFF9bc6bf),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Text('${viewModel.user!.displayName}님',
                style: AppTextStyle.body20B()),
            Text(
              '${viewModel.user!.email}',
              style: AppTextStyle.body14R(color: AppColors.info),
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(8, 32, 8, 32),
                child: AdvertisingArea()),
            if (viewModel.manager == true)
              InkwellRowTile(
                  text: '그룹 관리',
                  onTap: () {
                    viewModel.goToGroupSettingPage(context);
                  },
                  icon: Icons.group_rounded),
            InkwellRowTile(
                text: '회원탈퇴',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return TwoAnswerDialog(
                            onTap: () {
                              viewModel.deleteAccount(context);
                            },
                            title: '회원 탈퇴 알림',
                            subtitle: '정말 탈퇴하시겠습니까?',
                            firstButton: '네',
                            secondButton: '아니오');
                      });
                },
                icon: Icons.output_rounded),
            InkwellRowTile(
                text: '비밀번호 변경',
                onTap: () {
                  // context.go('/changePassword');
                  context.push(Uri(path: '/changePassword').toString());
                },
                icon: Icons.lock_outline_rounded),
            InkwellRowTile(
                text: '로그아웃',
                onTap: () {
                  viewModel.signOut(context: context);
                },
                icon: Icons.power_settings_new),
          ],
        ),
      ),
    );
  }
}
