import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';

import '../custom_buttons/first_custom_button.dart';

class MakeFridge extends StatelessWidget {
  final List<RefrigeDetail> refrigeItems;
  final bool isManager;
  final int index;

  const MakeFridge({
    super.key,
    required this.refrigeItems,
    required this.isManager,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: GestureDetector(
            onTap: () => context.go('/details', extra: refrigeItems[index]),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 3),
                    blurRadius: 2.0,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  refrigeItems[index].refrigeName,
                ),
              ),
            ),
          ),
        ),
        //관리자 버튼
        isManager
            ? SuperNeumorphicButton(
                padding: EdgeInsets.all(0),
                onTap: () {
                  context.go('/editRefrige', extra: refrigeItems[index]);
                },
                height: 30,
                width: 60,
                child: Center(
                    child: Text(
                  '수정',
                  style: TextStyle(fontSize: 15, color: Colors.black),
                )),
              )

            // ElevatedButton(
            //         onPressed: () {
            //           context.go('/editRefrige', extra: refrigeItems[index]);
            //         },
            //         child: Text('수정'))
            : Container()
      ],
    );
  }
}
