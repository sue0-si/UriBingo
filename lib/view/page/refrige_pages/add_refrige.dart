import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view_model/add_page_view_model.dart';
import 'package:provider/provider.dart';

class addRefrige extends StatefulWidget {
  const addRefrige({super.key});

  @override
  State<addRefrige> createState() => _addRefrigeState();
}

class _addRefrigeState extends State<addRefrige> {
  final addPageViewModel = AddPageViewModel(); //AddPageViewModel 담을 변수 선언

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함

  RefrigeDetail newRefrige = RefrigeDetail(
    refrigeId: '0',
    // 적절한 값으로 수정
    refrigeName: '',
    // 적절한 값으로 수정
    refrigeCompCount: 0,
    // 적절한 값으로 수정
    freezerCompCount: 0,
    // 적절한 값으로 수정
    period: 0,
    // 적절한 값으로 수정
    extentionPeriod: 0, // 적절한 값으로 수정
  );

  @override
  void initState() {
    super.initState();
    addPageViewModel.initAddRefri(); //호출(단발성) - 함수를 포장해서 보내주자
  }

  @override
  void dispose() {
    addPageViewModel.addNameController.dispose(); //호출(단발성) - 함수를 포장해서 보내주자
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final addPageViewModel = context.watch<AddPageViewModel>();
    //뷰모델 람다식 상태변경을 인식하려고 notifyListeners(); - 함수를 포장해서 보내주자
    //위젯 전체를 인식하려고 쓴것이다

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
                                      return '냉장고 이름을 입력하세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                    addPageViewModel.name = value; //여기 잘 모르겠다
                                  },
                                  controller:
                                      addPageViewModel.addNameController,
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
                                        addPageViewModel.selectedColdstorage[0],
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
                                        print(addPageViewModel
                                            .selectedColdstorage);
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
                                    value: addPageViewModel
                                        .selectedFrozenStorage[0],
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
                                        addPageViewModel.selectedFrozenStorage =
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
                                    value: addPageViewModel.selectedStoragePeriod[0],
                                    items: addPageViewModel.frozenStorageOfCompartmentsList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel.selectedStoragePeriod = value!;
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
                                    value: addPageViewModel.selectedFrozenStorage[0],
                                    items: addPageViewModel.frozenStorageOfCompartmentsList
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        addPageViewModel.selectedExtensionPeriod = value!;
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          print('냉장고 이름: $addPageViewModel.name');

                          //_selectedColdstoragefmf 정수로 변환
                          int coldStorageValue =
                              int.parse(addPageViewModel.selectedColdstorage[0]);
                          int forzenStorageValue =
                              int.parse(addPageViewModel.selectedFrozenStorage[0]);
                          int storagePeriodValue =
                              int.parse(addPageViewModel.selectedStoragePeriod[0]);
                          int extentionPeriodValue =
                              int.parse(addPageViewModel.selectedExtensionPeriod[0]);

                          //함수 호출 시 정수 값을 전달
                          // inputAddRefrige(
                          //   coldStorageValue,
                          //   forzenStorageValue,
                          //   storagePeriodValue,
                          //   extentionPeriodValue,
                          // );
                        }
                        Navigator.pop(
                          context,
                          addPageViewModel,
                        );
                      },
                      child: const Text(
                        '추가하기',
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

  // void inputAddRefrige(
  //   int coldStorageValue,
  //   int forzenStorageValue,
  //   int storagePeriodValue,
  //   int extentionPeriodValue,
  // ) {
  //   //RefrigeDetail? newRefrige;
  //
  //   newRefrige.refrigeName = _addNameController.text;
  //   newRefrige.refrigeCompCount = coldStorageValue;
  //   newRefrige.freezerCompCount = forzenStorageValue;
  //   newRefrige.period = storagePeriodValue;
  //   newRefrige.extentionPeriod = extentionPeriodValue;
  //
  //   print(coldStorageValue);
  //   print(forzenStorageValue);
  //   print(storagePeriodValue);
  //   print(extentionPeriodValue);
  // }
}
