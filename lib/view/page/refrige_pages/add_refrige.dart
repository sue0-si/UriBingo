import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';

class addRefrige extends StatefulWidget {
  const addRefrige({super.key});

  @override
  State<addRefrige> createState() => _addRefrigeState();
}

class _addRefrigeState extends State<addRefrige> {
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

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); //textFormfield 사용하려면 설정해야함

  final _addNameController = TextEditingController();

  final _coldStorageOfCompartments = ['1칸', '2칸', '3칸', '4칸', '5칸']; //냉장고칸수
  final _frozenStorageOfCompartments = ['1칸', '2칸', '3칸', '4칸', '5칸']; //냉동고칸수
  final _storagePeriod = ['1일', '2일', '3일', '4일', '5일']; //보관기간
  final _extensionPeriod = ['1일', '2일', '3일', '4일', '5일']; //연장가능기간

  String _selectedColdstorage = ''; //선택된냉장칸수
  String _selectedFrozenStorage = ''; //선택된냉동칸수
  String _selectedStoragePeriod = ''; //선택된보관기간
  String _selectedExtensionPeriod = ''; //선택된연장가능기간

  String? _name; //validate 값 저장되는 변수

  @override
  void initState() {
    super.initState();

    _selectedColdstorage = _coldStorageOfCompartments[0];
    _selectedFrozenStorage = _frozenStorageOfCompartments[0];
    _selectedStoragePeriod = _storagePeriod[0];
    _selectedExtensionPeriod = _extensionPeriod[0];
  }

  @override
  void dispose() {
    _addNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                                    _name = value;
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
                                    value: _selectedColdstorage,
                                    items: _coldStorageOfCompartments
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e
                                                  .toString()), //int를 String으로 변환
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedColdstorage = value!;
                                        print(_selectedColdstorage);
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
                                    value: _selectedFrozenStorage,
                                    items: _frozenStorageOfCompartments
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedFrozenStorage = value!;
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
                                    value: _selectedStoragePeriod,
                                    items: _storagePeriod
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedStoragePeriod = value!;
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
                                    value: _selectedExtensionPeriod,
                                    items: _extensionPeriod
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedExtensionPeriod = value!;
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
                          print('냉장고 이름: $_name');

                          //_selectedColdstoragefmf 정수로 변환
                          int coldStorageValue =
                              int.parse(_selectedColdstorage[0]);
                          int forzenStorageValue =
                              int.parse(_selectedFrozenStorage[0]);
                          int storagePeriodValue =
                              int.parse(_selectedColdstorage[0]);
                          int extentionPeriodValue =
                              int.parse(_selectedExtensionPeriod[0]);

                          //함수 호출 시 정수 값을 전달
                          inputAddRefrige(
                            coldStorageValue,
                            forzenStorageValue,
                            storagePeriodValue,
                            extentionPeriodValue,
                          );
                        }
                        context.pushNamed(
                          "mainScreen",
                          extra: newRefrige,
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

  void inputAddRefrige(
    int coldStorageValue,
    int forzenStorageValue,
    int storagePeriodValue,
    int extentionPeriodValue,
  ) {
    //RefrigeDetail? newRefrige;

    newRefrige.refrigeName = _addNameController.text;
    newRefrige.refrigeCompCount = coldStorageValue;
    newRefrige.freezerCompCount = forzenStorageValue;
    newRefrige.period = storagePeriodValue;
    newRefrige.extentionPeriod = extentionPeriodValue;

    print(coldStorageValue);
    print(forzenStorageValue);
    print(storagePeriodValue);
    print(extentionPeriodValue);
  }
}
