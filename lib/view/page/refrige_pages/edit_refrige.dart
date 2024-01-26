import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view/page/main_my_fridge/main_page.dart';
import 'package:leute/view/page/main_my_fridge/main_screen.dart';
import 'package:provider/provider.dart';

import '../../../data/models/refrige_model.dart';
import '../../../view_model/add_page_view_model.dart';

class EditRefrige extends StatefulWidget {
  const EditRefrige({super.key, required this.refrigeDetail}); //외부 인자값을 받아오는거

  final RefrigeDetail refrigeDetail;



  @override
  State<EditRefrige> createState() => _EditRefrigeState();
}

class _EditRefrigeState extends State<EditRefrige> {
  final addPageViewModel = AddPageViewModel();





  final addNameController = TextEditingController();

//addNameController 외부접근
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함
  @override
  void initState() {
    addPageViewModel.name = widget.refrigeDetail.refrigeName;
    super.initState();
  }

  @override
  void dispose() {
    addNameController.dispose(); //호출(단발성) - 함수를 포장해서 보내주자
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editPageViewModel = context.watch<AddPageViewModel>();

    addPageViewModel.selectedStoragePeriod =
    '${widget.refrigeDetail.refrigeCompCount}칸'; //수정 초기값 설정 = 파이어베이스에서 받아서 내려온 값
    addPageViewModel.selectedFrozenStorage =
    '${widget.refrigeDetail.freezerCompCount}칸';
    addPageViewModel.selectedStoragePeriod = '${widget.refrigeDetail.period}일';
    addPageViewModel.selectedExtensionPeriod =
    '${widget.refrigeDetail.extentionPeriod}일';

    addPageViewModel.registerDate = '${widget.refrigeDetail.registerDate}일';

    return Scaffold(
      appBar: AppBar(
        actions: [],
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
                  child: Container(
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
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return widget.refrigeDetail.refrigeName;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                    editPageViewModel.name = value!; //여기 잘 모르겠다
                                  },
                                  controller: addNameController,
                                  //obscureText: true, 입력값을 안보여주고싶을때
                                  style: TextStyle(fontSize: 15),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
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
                            SizedBox(
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
                                margin: EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    value:
                                    addPageViewModel.selectedColdstorage,
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
                                        addPageViewModel.selectedColdstorage =
                                            value!;
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
                                margin: EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    value:
                                    addPageViewModel.selectedFrozenStorage,
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
                                        addPageViewModel
                                            .selectedFrozenStorage = value!;
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
                                margin: EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    value:
                                    addPageViewModel.selectedStoragePeriod,
                                    items: addPageViewModel.storagePeriodList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel
                                            .selectedStoragePeriod = value!;
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
                                margin: EdgeInsets.only(right: 40),
                                child: DropdownButton(
                                    elevation: 10,
                                    dropdownColor: Colors.green,
                                    value: addPageViewModel
                                        .selectedExtensionPeriod,
                                    items: addPageViewModel.extensionPeriodList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel
                                            .selectedExtensionPeriod = value!;
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
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          await editPageViewModel.changeColdstorage();
                          if (mounted) {
                            context
                                .go('/', extra: {'addPageViewModel': MainPage});
                          }
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
                      onPressed: () {},
                      child: Text(
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
          ),
        ),
      ),
    );
  }
}
