import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view_model/add_page_view_model.dart';
import 'package:provider/provider.dart';

import '../../widget/custom_dialog/two_answer_dialog.dart';

class EditRefrige extends StatefulWidget {
  const EditRefrige({super.key, required this.seletedRefrige});

  final RefrigeDetail seletedRefrige;

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/', extra: 0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                '냉장고 이름',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Form(
                                key: _formKey,
                                child: TextFormField(
                                  enabled: false,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return addPageViewModel.name;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                    addPageViewModel.name = value!; //여기 잘 모르겠다
                                  },
                                  controller: addNameController,
                                  //obscureText: true, 입력값을 안보여주고싶을때
                                  style: const TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.only(
                                      left: 15,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.green,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.green,
                                      ),
                                    ),
                                    //hintText: '이름을 입력하세요',
                                    labelText: '이름을 입력하세요',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                        // 이 부분을 수정하여 두 번째 냉장고 이름을 표시하세요.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                '냉장고 칸수',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    value: selectedColdstorageController.text,
                                    items: addPageViewModel
                                        .coldStorageOfCompartmentsList //String이 아닌 List<String>을 반환되고 있다
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedColdstorageController.text =
                                            value!;
                                        addPageViewModel.selectedColdstorage =
                                            value;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                '냉동고 칸수',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    value: selectedFrozenStorageController.text,
                                    items: addPageViewModel
                                        .frozenStorageOfCompartmentsList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              flex: 1,
                              child: Text(
                                '보관기간',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    value: selectedStoragePeriodController.text,
                                    items: addPageViewModel.storagePeriodList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Expanded(
                              child: Text(
                                '연장가능기간',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: const EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    elevation: 10,
                                    dropdownColor: Colors.green,
                                    value:
                                        selectedExtensionPeriodController.text,
                                    items: addPageViewModel.extensionPeriodList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedExtensionPeriodController.text =
                                            value!;
                                        addPageViewModel
                                            .selectedExtensionPeriod = value;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            //왜 async?
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return TwoAnswerDialog(
                                        title: '수정하시겠습니까?',
                                        subtitle: '',
                                        titleStyle: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        firstButton: '네',
                                        secondButton: '아니오',
                                        onTap: () async {
                                          setState(() {});

                                          if (mounted) {
                                            context.go('/', extra: 0);
                                          }
                                          await addPageViewModel.editRefrige(
                                              selectedColdstorageController
                                                  .text,
                                              selectedFrozenStorageController
                                                  .text,
                                              selectedStoragePeriodController
                                                  .text,
                                              selectedExtensionPeriodController
                                                  .text);
                                        });
                                  });

                              //changeColdstorage 메서드 호출해서 데이터 저장
                            }
                          },
                          child: const Text(
                            '수정하기',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return TwoAnswerDialog(
                                  title: '삭제하겠습니까?',
                                  subtitle: '삭제 후 복구가 불가합니다.',
                                  firstButton: '네',
                                  secondButton: '아니오',
                                  onTap: () async {
                                    await addPageViewModel.remainFoodsCheck(
                                        widget.seletedRefrige.refrigeName);
                                    if (addPageViewModel.foodItems.isNotEmpty) {
                                      if (mounted) {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return TwoAnswerDialog(
                                              title:
                                                  '음식이 남아있습니다. 그래도 삭제하시겠습니까?',
                                              subtitle: '삭제 후 복구가 불가합니다.',
                                              firstButton: '네',
                                              secondButton: '아니오',
                                              onTap: () async {
                                                await addPageViewModel
                                                    .deleteRefrige();
                                                if (mounted) {
                                                  context.go('/', extra: 0);
                                                }
                                              },
                                            );
                                          },
                                        );
                                      }
                                    } else {
                                      await addPageViewModel.deleteRefrige();
                                      if (mounted) {
                                        context.go('/', extra: 0);
                                      }
                                    }
                                  },
                                );
                              },
                            );
                          },
                          child: const Text(
                            '삭제하기',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
