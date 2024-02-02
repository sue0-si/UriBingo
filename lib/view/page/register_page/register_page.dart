import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/repository/user_data_repository.dart';
import 'package:leute/styles/app_text_style.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/models/foods_model.dart';
import '../../../data/models/user_model.dart';
import 'register_view_model.dart';

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
    // final samePositionFoodList = widget.fridgeData[2] as List<FoodDetail>;
    final isFreezed = widget.fridgeData[3] as bool;

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: viewModel.isLoading
            ? Center(
                child: LoadingAnimationWidget.inkDrop(
                  color: const Color(0xFF9bc6bf),
                  size: 50,
                ),
              )
            : Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      await viewModel.pickImage();
                    },
                    child: Stack(
                      children: [
                        viewModel.photo == null ||
                                viewModel.photo?.readAsBytes() == null
                            ? SizedBox(
                                height: 200.h,
                                width: 300.w,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: Center(
                                    child: Text('음식 사진을 촬영해주세요',
                                        style: AppTextStyle.body15R(
                                            color: Colors.black)),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 200.h,
                                width: 300.w,
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  clipBehavior: Clip.hardEdge,
                                  child: viewModel.photo?.readAsBytes() == null
                                      ? const Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : Image.memory(
                                          viewModel.foodImage,
                                          width: 200.w,
                                          height: 500.h,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),

                        // FutureBuilder(
                        //         future: viewModel.photo?.readAsBytes(),
                        //         builder: (context, snapshot) {
                        //           final data = snapshot.data;
                        //           if (data == null ||
                        //               snapshot.connectionState ==
                        //                   ConnectionState.waiting) {
                        //             return const Center(
                        //               child: CircularProgressIndicator(),
                        //             );
                        //           }
                        //           return SizedBox(
                        //             height: 200.h,
                        //             width: 300.w,
                        //             child: Card(
                        //               elevation: 3,
                        //               shape: RoundedRectangleBorder(
                        //                 borderRadius:
                        //                     BorderRadius.circular(15.0),
                        //               ),
                        //               clipBehavior: Clip.hardEdge,
                        //               child: Image.memory(
                        //                 data,
                        //                 width: 200.w,
                        //                 height: 500.h,
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       ),
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            height: 45.h,
                            width: 45.w,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                                color: Colors.white),
                            child: viewModel.photo == null
                                ? const Icon(Icons.add_a_photo_rounded,
                                    size: 30, color: Color(0xFF9bc6bf))
                                : const Icon(Icons.change_circle,
                                    size: 30, color: Color(0xFF9bc6bf)),
                          ),
                        ),
                      ],
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
                                  context.go(
                                    '/details',
                                    extra: isFreezed
                                        ? [widget.fridgeData[0], 0]
                                        : [widget.fridgeData[0], 1],
                                  );
                                },
                                child: Text(
                                  '취소',
                                  style:
                                      AppTextStyle.body12R(color: Colors.black),
                                )),
                            // 등록하기 버튼
                            ElevatedButton(
                              onPressed: () async {
                                // 이미지 등록 안 했을 경우 에러 처리
                                if (viewModel.photo == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('사진을 등록해주세요.'),
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

                                  viewModel.changeLoadingState();

                                  // 사진 storage에 올리기
                                  await uploadRef.putData(
                                      viewModel.foodImage,
                                      SettableMetadata(
                                          contentType: "image/jpeg"));
                                  final downloadUrl =
                                      await uploadRef.getDownloadURL();

                                  await FirebaseFirestore.instance
                                      .collection('foodDetails')
                                      .doc(registerDate.toString() + userId)
                                      .set(FoodDetail(
                                        refrigeName:
                                            selectedRefrige.refrigeName,
                                        freezed: isFreezed,
                                        foodImage: downloadUrl,
                                        positionId: selectedPosition,
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        userName: FirebaseAuth.instance
                                                .currentUser!.displayName ??
                                            'noName',
                                        registerDate: registerDate,
                                        isPublic: viewModel.selected,
                                        isExtended: false,
                                      ).toJson());

                                  if (mounted) {
                                    viewModel.isLoading = false;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('등록되었습니다.'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                    context.go(
                                      '/details',
                                      extra: isFreezed
                                          ? [widget.fridgeData[0], 0]
                                          : [widget.fridgeData[0], 1],
                                    );
                                  }
                                }
                              },
                              child: Text('등록하기',
                                  style: AppTextStyle.body12R(
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 64.h,
                        ),
                        // 관리자만 보이는 버튼
                        isManager
                            ? Column(
                                children: [
                                  Text(
                                    '공용 여부를 선택해주세요',
                                    style: AppTextStyle.body14M(),
                                  ),
                                  SizedBox(
                                    height: 16.h,
                                  ),
                                  ToggleButtons(
                                      borderWidth: 3.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                      borderColor: const Color(0xFF9bc6bf),
                                      selectedBorderColor: const Color(0xFF9bc6bf),
                                      isSelected: [viewModel.selected],
                                      color: Colors.black,
                                      selectedColor: Colors.deepPurple,
                                      onPressed: (int index) {
                                        viewModel.buttonSelection(index);
                                      },
                                      children: [
                                        Text('공용',
                                            style: AppTextStyle.body12R(
                                                color: Colors.black)),
                                        // Text('미확인',
                                        //     style: AppTextStyle.body12R(
                                        //         color: Colors.black)),
                                      ]),
                                ],
                              )
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