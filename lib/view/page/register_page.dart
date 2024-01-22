import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  final List<bool> _selected = [false, false];
  int selectedIndex = 0;

  Future<void> pickImage() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickImage();
              },
              child: photo == null
                  ? Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      color: Colors.grey,
                      child: const Icon(Icons.image_rounded, size: 100),
                    )
                  : FutureBuilder(
                      future: photo?.readAsBytes(),
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
                      ElevatedButton(onPressed: () {}, child: const Text('취소')),
                      ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('등록되었습니다.'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          },
                          child: const Text('등록하기')),
                    ],
                  ),
                  const SizedBox(height: 32,),
                  // 관리자만 보이는 버튼
                  ToggleButtons(
                      children: [
                        const Text('공용'),
                        const Text('미확인'),
                      ],
                      isSelected: _selected,
                      color: Colors.black,
                      selectedColor: Colors.deepPurple,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selected.length; i++) {
                            _selected[i] = i == index;
                          }
                        });
                      }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
