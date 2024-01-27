import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view_model/register_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/models/foods_model.dart';
import '../../../data/models/user_model.dart';
import '../main_my_fridge/main_screen.dart';

class RegisterPage extends StatefulWidget {
  final List<Object> fridgeData;

  const RegisterPage({super.key, required this.fridgeData});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isManager = false;

  @override
  void initState() {
    getManagerStatus();
    super.initState();
  }

  Future getManagerStatus() async {
    List<UserModel> userData = await UserDataRepository().getFirebaseUserData();
    UserModel currentUser = userData.firstWhere(
        (user) => user.email == FirebaseAuth.instance.currentUser!.email);
    setState(() {
      isManager = currentUser.manager;
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<RegisterViewModel>();

    final selectedRefrige = widget.fridgeData[0] as RefrigeDetail;
    final selectedPosition = widget.fridgeData[1] as int;
    final samePositionFoodList = widget.fridgeData[2] as List<FoodDetail>;
    final isFreezed = widget.fridgeData[3] as bool;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                viewModel.changeImageFormat();
              },
              child: viewModel.photo == null
                  ?
              SizedBox(
                height: 200.h,
                width: 300.w,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: const Icon(Icons.image_rounded, size: 100),
                ),
              )
                  : FutureBuilder(
                      future: viewModel.photo?.readAsBytes(),
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        if (data == null ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return SizedBox(
                          height: 200.h,
                          width: 300.w,
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image.memory(
                              data,
                              width: 200.w,
                              height: 500.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                        // return Image.memory(
                        //   data,
                        //   width: 300.w,
                        //   height: 200.h,
                        //   fit: BoxFit.cover,
                        // );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 취소버튼
                      ElevatedButton(
                          onPressed: () {
                            context.go(isFreezed ? '/freezerDetail' : '/refrigeDetail', extra: widget.fridgeData[0]);
                          },
                          child: const Text('취소')),
                      // 등록하기 버튼
                      ElevatedButton(
                        onPressed: () async {
                          // 이미지 등록 안 했을 경우 에러 처리
                          if (viewModel.photo == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('이미지를 등록해주세요.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          } else {
                            final registerDate =
                                DateTime.now().millisecondsSinceEpoch;
                            final userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            final uploadRef = FirebaseStorage.instance
                                .ref('images')
                                .child('$registerDate.jpg');

                            // 사진 storage에 올리기
                            await uploadRef.putData(viewModel.foodImage,
                                SettableMetadata(contentType: "image/jpeg"));
                            final downloadUrl =
                                await uploadRef.getDownloadURL();

                            await FirebaseFirestore.instance
                                .collection('foodDetails')
                                .doc(registerDate.toString() + userId)
                                .set(FoodDetail(
                                  refrigeName: selectedRefrige.refrigeName,
                                  freezed: isFreezed,
                                  foodImage: downloadUrl,
                                  positionId: selectedPosition,
                                  userId:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  userName: FirebaseAuth
                                          .instance.currentUser!.displayName ??
                                      'noName',
                                  registerDate: registerDate,
                                  isPublic: viewModel.selected[0],
                                  isUnknown: viewModel.selected[1],
                                  isExtended: false,
                                ).toJson());

                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('등록되었습니다.'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                              context.go(isFreezed ? '/freezerDetail' : '/refrigeDetail', extra: widget.fridgeData[0]);
                            }
                          }
                        },
                        child: const Text('등록하기'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // 관리자만 보이는 버튼
                  isManager
                      ? ToggleButtons(
                          isSelected: viewModel.selected,
                          color: Colors.black,
                          selectedColor: Colors.deepPurple,
                          onPressed: (int index) {
                            viewModel.buttonSelection(index);
                          },
                          children: const [
                              Text('공용'),
                              Text('미확인'),
                            ])
                      : Container()
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
