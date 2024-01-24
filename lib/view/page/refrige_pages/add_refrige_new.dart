import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/view/page/refrige_pages/add_refrige_new_view_model.dart';
import 'package:provider/provider.dart';

class AddRefrige extends StatefulWidget {
  const AddRefrige({super.key});

  @override
  State<AddRefrige> createState() => _AddRefrigeState();
}

class _AddRefrigeState extends State<AddRefrige> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함

  final _addNameController = TextEditingController();



  @override
  void dispose() {
    _addNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<AddRefrigeViewModel>();
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
                                      return ' 냉장고 이름을 입력하세요';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    //유효성 검사 후, 폼이 제출될 때 저장되는 콜백
                                    viewModel.name = value!;
                                  },
                                  controller: _addNameController,
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
                                    value: viewModel.selectedColdstorage,
                                    items: viewModel.coldStorageOfCompartments
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e), //int를 String으로 변환
                                          ),
                                        )
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.selectedColdstorage = value!;
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
                                    value: viewModel.selectedFrozenStorage,
                                    items: viewModel.frozenStorageOfCompartments
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.selectedFrozenStorage =
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
                                    value: viewModel.selectedStoragePeriod,
                                    items: viewModel.storagePeriod
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.selectedStoragePeriod =
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
                                    value: viewModel.selectedExtensionPeriod,
                                    items: viewModel.extensionPeriod
                                        .map(
                                          (e) => DropdownMenuItem(
                                            value: e,
                                            child: Text(e),
                                          ),
                                        )
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.selectedExtensionPeriod =
                                            value!;
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
                          print('냉장고 이름: $viewModel.name');

                          //함수 호출 시 정수 값을 전달
                          await viewModel.addRefrigeToStorage();
                          if (mounted) {
                            context.pop();
                          }
                        }
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
}
