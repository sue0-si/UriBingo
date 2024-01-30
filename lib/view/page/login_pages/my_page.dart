import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_widget/Inkwell_row_tile.dart';
import 'package:leute/view/widget/login_widget/advertising_area.dart';
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
            style: AppTextStyle.header20(color: AppColors.mainText),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
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
    );
  }
}
