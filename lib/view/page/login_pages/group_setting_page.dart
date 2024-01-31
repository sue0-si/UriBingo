import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:unicons/unicons.dart';

import '../../../view_model/group_setting_page_view_model.dart';
import '../../widget/custom_dialog/one_answer_dialog.dart';

class GroupSettingPage extends StatefulWidget {
  const GroupSettingPage({super.key});

  @override
  State<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends State<GroupSettingPage> {
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupSettingPageViewModel>();
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
                    '그룹원 찾기',
                    style: AppTextStyle.body16B(),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: LoginTextfield(
                            hintText: '이름 또는 이메일', controller: nameController),
                      ),
                      const SizedBox(width: 4),
                      ElevatedButton(
                        onPressed: () {
                          viewModel.searchUser(nameController.text);
                        },
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(30.w, 56.h)),
                            //테두리 모양 조절
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            backgroundColor: MaterialStateProperty.all(
                                AppColors.mainButton)),
                        child: const Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('그룹원 리스트 (${viewModel.fetchedUserList.length})',
                      style: AppTextStyle.body16B()),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.fetchData();
                    },
                    style: ButtonStyle(
                        //테두리 모양 조절
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            MaterialStateProperty.all(AppColors.mainButton)),
                    child: Text('전체',
                        style: AppTextStyle.body12R(color: Colors.white)),
                  )
                ],
              ),
            ),
            Expanded(
              child: (viewModel.isLoading)
                  ? Center(
                      child: LoadingAnimationWidget.inkDrop(
                        color: const Color(0xFF9bc6bf),
                        size: 50,
                      ),
                    )
                  : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: viewModel.fetchedUserList.length,
                      itemBuilder: (context, index) {
                        final fetchedUser = viewModel.fetchedUserList[index];
                        return ListTile(
                          title: Text(
                            fetchedUser.name,
                            style: AppTextStyle.body16B(),
                          ),
                          subtitle: Text(
                            fetchedUser.email,
                            style: AppTextStyle.body14R(),
                          ),
                          trailing: SizedBox(
                            height: 40,
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewModel.managerCheckBoxTap(fetchedUser);
                                    // print(viewModel.fetchedUserList.where((e) => e.manager ==true).toList().length);
                                  },
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '관리자',
                                        style: AppTextStyle.body14R(),
                                      ),
                                      RoundCheckBox(
                                        checkedWidget: const Icon(
                                          UniconsLine.check,
                                          size: 13,
                                        ),
                                        checkedColor: const Color(0xFF9bc6bf),
                                        isRound: false,
                                        size: 14,
                                        isChecked: (fetchedUser.manager == true)
                                            ? true
                                            : false,
                                        onTap: (selected) {
                                          viewModel
                                              .managerCheckBoxTap(fetchedUser);
                                          // print(viewModel.fetchedUserList.where((e) => e.manager ==true).toList().length);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Text('삭제',
                                        style: AppTextStyle.body14R())),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final managerList = viewModel.groupUserList
                      .where((user) => user.manager == true)
                      .toList();
                  if (managerList.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (desContext) {
                          return OneAnswerDialog(
                            onTap: () {
                              (nameController.text.isNotEmpty)
                                  ? viewModel.searchUser(nameController.text)
                                  : viewModel.fetchData();
                              Navigator.of(context, rootNavigator: true).pop();
                            },
                            title: '',
                            subtitle: '관리자가 아무도 없습니다.',
                            firstButton: '취소',
                          );
                        });
                  } else {
                    await viewModel.editManager(viewModel.fetchedUserList);
                    if (viewModel.isLoading) {
                      Center(
                        child: LoadingAnimationWidget.inkDrop(
                          color: const Color(0xFF9bc6bf),
                          size: 50,
                        ),
                      );
                    } else {
                      if (mounted) {
                        showDialog(
                            context: context,
                            builder: (desContext) {
                              return OneAnswerDialog(
                                onTap: () {
                                  (nameController.text.isNotEmpty)
                                      ? viewModel
                                          .searchUser(nameController.text)
                                      : viewModel.fetchData();
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                title: '',
                                subtitle: '변경되었습니다',
                                firstButton: '확인',
                              );
                            });
                      }
                    }
                  }
                },
                style: ButtonStyle(
                    //테두리 모양 조절
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.mainButton)),
                child: Text('변경하기', style: AppTextStyle.body16B()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
