import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => context.go('/details', extra: refrigeItems[index]),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/new_refrig_icon_eunjin.png'),
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Center(
                  child: Text(
                    refrigeItems[index].refrigeName,
                  ),
                ),
              ],
            ),
          ),
          //관리자 버튼
          isManager
              ? ElevatedButton(
                  onPressed: () {
                    context.go('/editRefrige', extra: refrigeItems[index]);
                  },
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
      ),
    );
  }
}
