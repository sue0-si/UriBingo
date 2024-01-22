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

  pickImage() async {
    photo = await picker.pickImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          // photo == null
          //     ? const Center(
          //         child: Text('No data'),
          //       )
          //     : FutureBuilder(
          //         future: photo?.readAsBytes(),
          //         builder: (context, snapshot) {
          //           final data = snapshot.data;
          //           if (data == null ||
          //               snapshot.connectionState == ConnectionState.waiting) {
          //             return const Center(
          //               child: CircularProgressIndicator(),
          //             );
          //           }
          //           return Image.memory(
          //             data,
          //             width: double.infinity,
          //           );
          //         },
          //       )
          Container(
            height: 50,
            color: Colors.grey,
          ),
          ElevatedButton(onPressed: () {}, child: Text('취소')),
          ElevatedButton(onPressed: () {}, child: Text('등록하기')),
          ElevatedButton(onPressed: () {}, child: Text('공용')),
          ElevatedButton(onPressed: () {}, child: Text('미확인')),
        ],
      )),
    );
  }
}
