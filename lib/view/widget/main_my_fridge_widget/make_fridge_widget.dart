import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/styles/app_text_style.dart';

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
                      image: AssetImage(
                          'assets/images/lemon.png'),
                    ),
                    color: Colors.white,
                    // borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Center(
                  child: Text(
                    refrigeItems[index].refrigeName,
                    style: AppTextStyle.body12R(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          //관리자 버튼
          currentUser.manager
              ? ElevatedButton(
                  onPressed: () {
                    context.go('/editRefrige', extra: [refrigeItems[index], currentUser]);
                  },
                  child: Center(
                      child: Text(
                    '수정',
                    style: AppTextStyle.body12R(color: Colors.black),
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
