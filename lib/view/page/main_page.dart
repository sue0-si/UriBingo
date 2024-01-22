import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:leute/styles/app_text_colors.dart';
import 'package:leute/styles/app_text_style.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _numberOfCompartments = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int _selectedCompartments = 0;

  @override
  void initState() {
    setState(() {
      _selectedCompartments = _numberOfCompartments[0];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  height: 300,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                      
                        children: [
                          Expanded(
                            child: const Text(
                              '냉장고 이름',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 150,
                              height: 40,
                              child: TextField(
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 3,
                                      color: Colors.green,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      width: 3,
                                      color: Colors.green,
                                    ),
                                  ),
                                  hintText: '이름을 입력하세요',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 이 부분을 수정하여 두 번째 냉장고 이름을 표시하세요.
                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              '냉장고 칸수',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                                value: _selectedCompartments,
                                items: _numberOfCompartments
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.toString()),//int를 String으로 변환
                                        )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCompartments = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              '냉동고 칸수',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                                value: _selectedCompartments,
                                items: _numberOfCompartments
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString()),//int를 String으로 변환
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCompartments = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              '보관기간',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                                value: _selectedCompartments,
                                items: _numberOfCompartments
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString()),//int를 String으로 변환
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCompartments = value!;
                                  });
                                }),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              '연장가능기간',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Expanded(
                            child: DropdownButton(
                                value: _selectedCompartments,
                                items: _numberOfCompartments
                                    .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.toString()),//int를 String으로 변환
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedCompartments = value!;
                                  });
                                }),
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
                    onPressed: () {},
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
    );
  }
}
