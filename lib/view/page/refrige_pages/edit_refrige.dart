import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_buttons/custom_button.dart';
import 'package:leute/view_model/add_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../../styles/app_text_colors.dart';
import '../../widget/custom_dialog/two_answer_dialog.dart';

class EditRefrige extends StatefulWidget {
  const EditRefrige(
      {super.key, required this.seletedRefrige, required this.currentUser});

  final RefrigeDetail seletedRefrige;
  final UserModel currentUser;

  @override
  State<EditRefrige> createState() => _EditRefrigeState();
}

class _EditRefrigeState extends State<EditRefrige> {
  final addPageViewModel = AddPageViewModel();

  //final addPageViewModel = AddPageViewModel(); //AddPageViewModel 담을 변수 선언
  final addNameController = TextEditingController();
  final selectedColdstorageController = TextEditingController();
  final selectedFrozenStorageController = TextEditingController();
  final selectedStoragePeriodController = TextEditingController();
  final selectedExtensionPeriodController = TextEditingController();

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함

  @override
  void initState() {
    addNameController.text = widget.seletedRefrige.refrigeName;
    selectedColdstorageController.text =
        '${widget.seletedRefrige.refrigeCompCount}칸';
    selectedFrozenStorageController.text =
        '${widget.seletedRefrige.freezerCompCount}칸';
    selectedStoragePeriodController.text = '${widget.seletedRefrige.period}일';
    selectedExtensionPeriodController.text =
        '${widget.seletedRefrige.extentionPeriod}일';
    super.initState();
  }

  @override
  void dispose() {
    addNameController.dispose(); //호출(단발성) - 함수를 포장해서 보내주자
    selectedColdstorageController.dispose();
    selectedFrozenStorageController.dispose();
    selectedStoragePeriodController.dispose();
    selectedExtensionPeriodController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addPageViewModel = context.watch<AddPageViewModel>();
    addPageViewModel.registerdDate = widget.seletedRefrige.registerDate;
    addPageViewModel.initialName = widget.seletedRefrige.refrigeName;

    //뷰모델 람다식 상태변경을 인식하려고 notifyListeners(); - 함수를 포장해서 보내주자
    //위젯 전체를 인식하려고 쓴것이다

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF9bc6bf),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/main_page', extra: 0),
        ),
        title: Text(
          '냉장고 수정',
          style: AppTextStyle.header24(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0).r,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '냉장고 이름',
                          style: AppTextStyle.body18R(),
                        ),
                        SizedBox(
                          width: 150,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return addPageViewModel.name;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                addPageViewModel.name = value!;
                              },
                              controller: addNameController,
                              //obscureText: true, 입력값을 안보여주고싶을때
                              style: AppTextStyle.body15R(color: Colors.grey),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15.0),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).r,
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                labelText: '수정불가',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // 이 부분을 수정하여 두 번째 냉장고 이름을 표시하세요.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '냉장고 칸수',
                          style: AppTextStyle.body18R(),
                        ),
                        SizedBox(
                          width: 180,
                          child: Container(
                            margin: const EdgeInsets.only(left: 27).w,
                            child: DropdownButton(
                                menuMaxHeight: 270,
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: selectedColdstorageController.text,
                                items: addPageViewModel
                                    .coldStorageOfCompartmentsList //String이 아닌 List<String>을 반환되고 있다
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Center(child: Text(e)),
                                        ))
                                    .toList(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    selectedColdstorageController.text = value!;
                                    addPageViewModel.selectedColdstorage =
                                        value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '냉동고 칸수',
                          style: AppTextStyle.body18R(),
                        ),
                        SizedBox(
                          width: 180,
                          child: Container(
                            margin: const EdgeInsets.only(left: 27).w,
                            child: DropdownButton(
                                menuMaxHeight: 270,
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: selectedFrozenStorageController.text,
                                items: addPageViewModel
                                    .frozenStorageOfCompartmentsList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Center(child: Text(e)),
                                        ))
                                    .toList(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    selectedFrozenStorageController.text =
                                        value!;
                                    addPageViewModel.selectedFrozenStorage =
                                        value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '보관기간',
                          style: AppTextStyle.body18R(),
                        ),
                        SizedBox(
                          width: 180,
                          child: Container(
                            margin: const EdgeInsets.only(left: 27).w,
                            child: DropdownButton(
                                menuMaxHeight: 270,
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: selectedStoragePeriodController.text,
                                items: addPageViewModel.storagePeriodList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Center(child: Text(e)),
                                        ))
                                    .toList(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    selectedStoragePeriodController.text =
                                        value!;
                                    addPageViewModel.selectedStoragePeriod =
                                        value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '연장가능기간',
                          style: AppTextStyle.body18R(),
                        ),
                        SizedBox(
                          width: 180,
                          child: Container(
                            margin: const EdgeInsets.only(left: 27).w,
                            child: DropdownButton(
                                menuMaxHeight: 270,
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: selectedExtensionPeriodController.text,
                                items: addPageViewModel.extensionPeriodList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Center(child: Text(e)),
                                        ))
                                    .toList(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    selectedExtensionPeriodController.text =
                                        value!;
                                    addPageViewModel.selectedExtensionPeriod =
                                        value;
                                  });
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomButton(
                            width: 100.w,
                            height: 35.h,
                            backgroundColor: const Color(0xFF9bc6bf),
                            textStyle:
                                AppTextStyle.body15R(color: Colors.white),
                            text: '수정하기',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TwoAnswerDialog(
                                          title: '수정하시겠습니까?',
                                          subtitle: '',
                                          secondButton: '아니오',
                                          firstButton: '네',
                                          onTap: () async {
                                            setState(() {});
                                            if (mounted) {
                                              context.go('/main_page',
                                                  extra: 0);
                                            }
                                            await addPageViewModel.editRefrige(
                                                selectedColdstorageController
                                                    .text,
                                                selectedFrozenStorageController
                                                    .text,
                                                selectedStoragePeriodController
                                                    .text,
                                                selectedExtensionPeriodController
                                                    .text,
                                                widget.currentUser);
                                          });
                                    });

                                //changeColdstorage 메서드 호출해서 데이터 저장
                              }
                            }),
                        CustomButton(
                          width: 100.w,
                          height: 35.h,
                          backgroundColor: Colors.grey.shade200,
                          textStyle:
                              AppTextStyle.body15R(color: AppColors.mainText),
                          text: '삭제하기',
                          onTap: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return TwoAnswerDialog(
                                      title: '삭제하시겠습니까?',
                                      subtitle: '냉장고가 완전히 삭제됩니다.',
                                      firstButton: '네',
                                      secondButton: '아니오',
                                      onTap: () async {
                                        setState(() {});

                                        if (mounted) {
                                          context.go('/main_page', extra: 0);
                                        }
                                        await addPageViewModel.deleteRefrige();
                                      });
                                });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
