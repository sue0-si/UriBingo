import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';

class GroupSettingPage extends StatefulWidget {
  const GroupSettingPage({super.key});

  @override
  State<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends State<GroupSettingPage> {
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      context.go('/', extra: 2);
                    },
                    icon: const Icon(Icons.arrow_back)),
                Text(
                  '그룹 관리',
                  style: AppTextStyle.header20(color: AppColors.mainText),
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '그룹원 추가',
                    style: AppTextStyle.body15B(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LoginTextfield(
                            hintText: '이메일', controller: emailController),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(30.w, 56.h)),
                            //테두리 모양 조절
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.mainButton)),
                        child: Text('추가',
                            style: AppTextStyle.body20B(color: Colors.white)),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('그룹원 리스트', style: AppTextStyle.body15B()),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '홍길동',
                        style: AppTextStyle.body15B(),
                      ),
                      subtitle: Text(
                        'test3@test.com',
                        style: AppTextStyle.body14R(),
                      ),
                      trailing: InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.delete,
                          color: AppColors.info,
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
