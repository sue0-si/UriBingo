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

  Future<void> pickImage() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    pickImage();
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
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.grey,
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
            ElevatedButton(onPressed: () {}, child: Text('취소')),
            ElevatedButton(onPressed: () {}, child: Text('등록하기')),
            ElevatedButton(onPressed: () {}, child: Text('공용')),
            ElevatedButton(onPressed: () {}, child: Text('미확인')),
          ],
        ),
      )),
    );
  }
}
