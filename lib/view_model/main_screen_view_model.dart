import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';
import 'package:leute/data/repository/refrige_repository.dart';
import 'package:leute/view/page/main_my_fridge/main_screen.dart';
import 'package:leute/view/widget/main_my_fridge_widget/make_fridge_widget.dart';

class MainScreenViewModel extends ChangeNotifier {
  List<Widget> fridges = [];
  List<RefrigeDetail> refrigeItems = [];

  final UserDataRepository userDataRepository = UserDataRepository();
  bool isManager = false;

  bool _disposed = false;

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  MainScreenViewModel() {
    fetchFridgeData();
  }

  Future<void> fetchFridgeData() async {
    //비동기로 변경
    refrigeItems = await RegisterdRefrigeRepository().getFirebaseRefrigesData();
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    UserModel currentUser = userData.firstWhere(
        (user) => user.email == FirebaseAuth.instance.currentUser!.email);
    isManager = currentUser.manager;

    for (int i = 1; i <= refrigeItems.length; i++) {
      fridges.add(MakeFridge(
          refrigeItems: refrigeItems, isManager: isManager, index: i - 1));
    }
    notifyListeners();
  }


// Widget makeFridge(int index) {
//   return Column(
//     children: [
//       GestureDetector(
//         onTap: () => context.go('/details', extra: refrigeItems[index]),
//         child: Container(
//           height: 150,
//           decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.black12),
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 offset: Offset(0, 3),
//                 blurRadius: 2.0,
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               refrigeItems[index].refrigeName,
//             ),
//           ),
//         ),
//       ),
//       //관리자 버튼
//       isManager
//           ? ElevatedButton(
//           onPressed: () {
//             context.go('/editRefrige', extra: refrigeItems[index]);
//           },
//           child: Text('수정'))
//           : Container()
//     ],
//   );
// }
}
