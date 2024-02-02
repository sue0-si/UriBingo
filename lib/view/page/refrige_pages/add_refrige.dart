import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_buttons/custom_button.dart';
import 'package:leute/view_model/add_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_dialog/two_answer_dialog.dart';

class AddRefrige extends StatefulWidget {
  const AddRefrige({super.key, required this.currentUser});

  final UserModel currentUser;

  //외부에서 값을 받아올 수 있다

  @override
  State<AddRefrige> createState() => _AddRefrigeState();
}

class _AddRefrigeState extends State<AddRefrige> {
  final _addNameController = TextEditingController();

  TextEditingController get addNameController =>
      _addNameController; //addNameController 외부접근
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함

  @override
  void dispose() {
    addNameController.dispose(); //호출(단발성) - 함수를 포장해서 보내주자
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addPageViewModel = context.watch<AddPageViewModel>();
    //뷰모델 람다식 상태변경을 인식하려고 notifyListeners(); - 함수를 포장해서 보내주자
    //위젯 전체를 인식하려고 쓴것이다

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '냉장고 추가',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w200,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF9bc6bf),
        //actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0).w,
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
                              maxLength: 7,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '냉장고 이름을 입력하세요';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                addPageViewModel.name = value!; //여기 잘 모르겠다
                              },
                              controller: addNameController,

                              style: TextStyle(
                                fontSize: 15.sp,
                              ),
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: Colors.green,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10).w,
                                  borderSide: BorderSide(
                                    width: 1.r,
                                    color: Colors.green,
                                  ),
                                ),
                                counterText: '',
                                labelText: '입력(최대7글자)',
                                labelStyle: TextStyle(
                                  color: Colors.grey.withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //SizedBox(
                        //width: 25.w,
                        //),
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
                              borderRadius: BorderRadius.circular(20),
                              iconEnabledColor: Colors.redAccent,
                              elevation: 2,
                              value: addPageViewModel.selectedColdstorage,
                              items: addPageViewModel
                                  .coldStorageOfCompartmentsList //String이 아닌 List<String>을 반환되고 있다
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Center(
                                          child: Text(e),
                                        ),
                                      ))
                                  .toList(),
                              isExpanded: true,
                              onChanged: (value) {
                                setState(() {
                                  addPageViewModel.selectedColdstorage = value!;
                                });
                              },
                            ),
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
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: addPageViewModel.selectedFrozenStorage,
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
                                    addPageViewModel.selectedFrozenStorage =
                                        value!;
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
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: addPageViewModel.selectedStoragePeriod,
                                items: addPageViewModel.storagePeriodList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Center(child: Text(e)),
                                        ))
                                    .toList(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    addPageViewModel.selectedStoragePeriod =
                                        value!;
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
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 27).w,
                            child: DropdownButton(
                                borderRadius: BorderRadius.circular(20),
                                iconEnabledColor: Colors.redAccent,
                                elevation: 2,
                                value: addPageViewModel.selectedExtensionPeriod,
                                items: addPageViewModel.extensionPeriodList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Center(child: Text(e)),
                                        ))
                                    .toList(),
                                isExpanded: true,
                                onChanged: (value) {
                                  setState(() {
                                    addPageViewModel.selectedExtensionPeriod =
                                        value!;
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
                          textStyle: AppTextStyle.body15R(color: Colors.white),
                          text: '추가하기',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TwoAnswerDialog(
                                        title: '등록하시겠습니까?',
                                        subtitle: '등록된 냉장고 이름은 수정이 불가합니다.',
                                        firstButton: '네',
                                        secondButton: '아니오',
                                        onTap: () async {
                                          setState(() {});

                                          if (mounted) {
                                            context.go('/main_page', extra: 0);
                                          }
                                          await addPageViewModel
                                              .addRefrige(widget.currentUser);
                                        });
                                  });
                              //왜 async?
                            }
                          },
                        ),
                        CustomButton(
                          width: 100.w,
                          height: 35.h,
                          backgroundColor: Colors.grey.shade200,
                          textStyle:
                              AppTextStyle.body15R(color: AppColors.mainText),
                          text: '취소하기',
                          onTap: () {
                            context.go('/main_page', extra: 0);
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
