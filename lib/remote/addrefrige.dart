import 'package:flutter/material.dart';

class addRefrige extends StatefulWidget {
  const addRefrige({super.key});

  @override
  State<addRefrige> createState() => _addRefrigeState();
}

class _addRefrigeState extends State<addRefrige> {
  final _numberOfCompartments = ['1칸', '2칸', '3칸', '4칸', '5칸'];
  String _selectedCompartments = '';

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
                              child: TextField(
                                style: TextStyle(fontSize: 15),
                                decoration: InputDecoration(
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
                                  hintText: '이름을 입력하세요',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
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
                                    value: _selectedCompartments,
                                    items: _numberOfCompartments
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e
                                                  .toString()), //int를 String으로 변환
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCompartments = value!;
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
                                    value: _selectedCompartments,
                                    items: _numberOfCompartments
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e), //int를 String으로 변환
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCompartments = value!;
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
                                    value: _selectedCompartments,
                                    items: _numberOfCompartments
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e), //int를 String으로 변환
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCompartments = value!;
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
                                    value: _selectedCompartments,
                                    items: _numberOfCompartments
                                        .map((e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e), //int를 String으로 변환
                                            ))
                                        .toList(),
                                    isExpanded: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedCompartments = value!;
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
      ),
    );
  }
}
