import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_dialog/two_answer_dialog.dart';
import 'package:leute/view/widget/login_widget/login_textfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:unicons/unicons.dart';

import 'group_setting_page_view_model.dart';
import '../../widget/custom_dialog/one_answer_dialog.dart';

class GroupSettingPage extends StatefulWidget {
  const GroupSettingPage({super.key});

  @override
  State<GroupSettingPage> createState() => _GroupSettingPageState();
}

class _GroupSettingPageState extends State<GroupSettingPage> {
  TextEditingController searchMemberController = TextEditingController();
  TextEditingController addMemberController = TextEditingController();

  @override
  void dispose() {
    searchMemberController.dispose();
    addMemberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<GroupSettingPageViewModel>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32, bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        context.go('/main_page', extra: 2);
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
                              hintText: '이름 또는 이메일',
                              controller: searchMemberController),
                        ),
                        const SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: () {
                            viewModel.searchUser(searchMemberController.text);
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
                        physics: const BouncingScrollPhysics(
                            decelerationRate: ScrollDecelerationRate.fast),
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
                                  GestureDetector(
                                    onTap: () {
                                      viewModel
                                          .withdrawUserCheckBoxTap(fetchedUser);
                                    },
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '삭제',
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
                                          isChecked:
                                              (fetchedUser.validationCode == '')
                                                  ? true
                                                  : false,
                                          onTap: (selected) {
                                            viewModel.withdrawUserCheckBoxTap(
                                                fetchedUser);
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
              ),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
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
                                    (searchMemberController.text.isNotEmpty)
                                        ? viewModel.searchUser(
                                            searchMemberController.text)
                                        : viewModel.fetchData();
                                    searchMemberController.text = '';
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  title: '관리자가 아무도 없습니다.',
                                  subtitle: '',
                                  firstButton: '취소',
                                );
                              });
                        } else {
                          await viewModel
                              .editGroupUser(viewModel.fetchedUserList);
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
                                        (searchMemberController.text.isNotEmpty)
                                            ? viewModel.searchUser(
                                                searchMemberController.text)
                                            : viewModel.fetchData();
                                        searchMemberController.text = '';
                                        Navigator.of(context, rootNavigator: true)
                                            .pop();
                                      },
                                      title: '변경되었습니다.',
                                      subtitle: '',
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
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '그룹원 추가하기',
                            style: AppTextStyle.body16B(),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: LoginTextfield(
                                    hintText: '이메일',
                                    controller: addMemberController),
                              ),
                              const SizedBox(width: 4),
                              ElevatedButton(
                                  onPressed: () async {
                                    await viewModel.searchNoGroupUser(
                                        addMemberController.text);

                                    if (viewModel.addTargetMember.isNotEmpty) {
                                      if (mounted) {
                                        showDialog(
                                          context: context,
                                          builder: (desContext) {
                                            return TwoAnswerDialog(
                                              title: '추가할 정보를 확인하세요.',
                                              subtitle:
                                                  '이름: ${viewModel.addTargetMember[0].name}\n이메일: ${viewModel.addTargetMember[0].email}',
                                              firstButton: '확인',
                                              secondButton: '취소',
                                              onTap: () async {
                                                await viewModel.addToMember(
                                                    viewModel.addTargetMember[0]);
                                                viewModel.isLoading
                                                    ? Center(
                                                        child:
                                                            LoadingAnimationWidget
                                                                .inkDrop(
                                                          color: const Color(
                                                              0xFF9bc6bf),
                                                          size: 50,
                                                        ),
                                                      )
                                                    : viewModel.fetchData();
                                                addMemberController.text = '';
                                                if (mounted) {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                }
                                              },
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      if (mounted) {
                                        showDialog(
                                            context: context,
                                            builder: (desContext) {
                                              return OneAnswerDialog(
                                                onTap: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                },
                                                title: '찾을 수 없습니다.',
                                                subtitle: '이메일을 다시 확인하세요.',
                                                firstButton: '확인',
                                              );
                                            });
                                      }
                                    }
                                  },
                                  style: ButtonStyle(
                                      minimumSize: MaterialStateProperty.all(
                                          Size(30.w, 56.h)),
                                      //테두리 모양 조절
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      backgroundColor: MaterialStateProperty.all(
                                          AppColors.mainButton)),
                                  child: Text(
                                    '추가',
                                    style: AppTextStyle.body14R(),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
