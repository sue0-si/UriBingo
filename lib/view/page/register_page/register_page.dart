import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/view_model/register_view_model.dart';
import 'package:provider/provider.dart';

import '../../../data/models/foods_model.dart';

class RegisterPage extends StatefulWidget {
  final List<Object> fridgeData;

  const RegisterPage({super.key, required this.fridgeData});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  ? Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      color: Colors.grey,
                      child: const Icon(Icons.image_rounded, size: 100),
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
                        return Image.memory(
                          data,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.cover,
                        );
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
                      ElevatedButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text('취소')),
                      ElevatedButton(
                          onPressed: () async {
                            // 사진 firestore에 올리기
                            final uploadRef = FirebaseStorage.instance.ref('images').child('${DateTime.now().microsecondsSinceEpoch}.jpg');
                            await uploadRef.putData(viewModel.foodImage, SettableMetadata(contentType: "image/jpeg"));
                            final downloadUrl = await uploadRef.getDownloadURL();

                            final registerDate = DateTime.now().millisecondsSinceEpoch;
                            final userId = FirebaseAuth.instance.currentUser!.uid;

                            await FirebaseFirestore.instance
                                .collection('foodDetails').doc(registerDate.toString()+userId)
                                .set(FoodDetail(
                                        refrigeName: selectedRefrige.refrigeName,
                                        freezed: isFreezed,
                                        foodImage: downloadUrl,
                                        positionId: selectedPosition,
                                        userId: FirebaseAuth.instance.currentUser!.uid,
                                        userName: FirebaseAuth.instance.currentUser!.displayName ?? 'noName',
                                        registerDate: registerDate,
                                        isPublic: viewModel.selected[0],
                                        isUnknown: viewModel.selected[1],
                              ).toJson());

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('등록되었습니다.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            context.go('/details', extra: widget.fridgeData[0]);
                          },
                          child: const Text('등록하기')),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // 관리자만 보이는 버튼
                  ToggleButtons(
                      isSelected: viewModel.selected,
                      color: Colors.black,
                      selectedColor: Colors.deepPurple,
                      onPressed: (int index) {
                        viewModel.buttonSelection(index);
                      },
                      children: const [
                        Text('공용'),
                        Text('미확인'),
                      ]),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
