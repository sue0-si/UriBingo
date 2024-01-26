import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';

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
        GestureDetector(
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
        //관리자 버튼
        isManager
            ? ElevatedButton(
                onPressed: () {
                  context.go('/editRefrige', extra: refrigeItems[index]);
                },
                child: Text('수정'))
            : Container()
      ],
    );
  }
}
