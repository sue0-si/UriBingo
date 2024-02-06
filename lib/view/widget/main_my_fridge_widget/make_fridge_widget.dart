//메인 화면 냉장고

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/styles/app_text_style.dart';
import 'package:leute/view/widget/custom_buttons/custom_button.dart';

class MakeFridge extends StatelessWidget {
  final List<RefrigeDetail> refrigeItems;
  final UserModel currentUser;
  final int index;

  const MakeFridge({
    super.key,
    required this.refrigeItems,
    required this.currentUser,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          GestureDetector(
            onTap: () =>
                context.go('/details', extra: [refrigeItems[index], 1]),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/lemon.png'),
                    ),
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 100.w,
                  child: Center(
                    child: Text(
                      refrigeItems[index].refrigeName,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //관리자 버튼

          currentUser.manager
              ? CustomButton(
                  width: 65.w,
                  height: 25.h,
                  backgroundColor: Colors.grey.shade400,
                  text: '수정',
                  textStyle: AppTextStyle.body12R(color: Colors.white),
                  onTap: () {
                    context.go('/editRefrige',
                        extra: [refrigeItems[index], currentUser]);
                  },
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
