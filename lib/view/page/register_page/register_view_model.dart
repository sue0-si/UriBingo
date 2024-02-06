import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leute/view/page/register_page/register_state.dart';

import '../../../data/models/user_model.dart';
import '../../../domain/foods_repository.dart';
import '../../../domain/user_data_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final RegisterdFoodsRepository foodsRepository;
  final UserDataRepository userDataRepository;

  bool isManager = false;
  String groupName = '';

  final ImagePicker picker = ImagePicker();
  XFile? photo;
  late Uint8List foodImage;

  RegisterViewModel({
    required this.foodsRepository,
    required this.userDataRepository,
  }) {
    getManagerStatus();
  }

  Future getManagerStatus() async {
    List<UserModel> userData = await userDataRepository.getFirebaseUserData();
    UserModel currentUser = userData.firstWhere(
        (user) => user.email == FirebaseAuth.instance.currentUser!.email);
    isManager = currentUser.manager;
    groupName = currentUser.groupName;
    notifyListeners();
  }

  RegisterState _state = const RegisterState(isLoading: false, selected: false);

  RegisterState get state => _state;

  void changeLoadingState() {
    _state = state.copyWith(isLoading: !_state.isLoading);
    notifyListeners();
  }

  Future<Uint8List?> pickImage() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    if (await photo?.readAsBytes() == null) {
      notifyListeners();
      return null;
    }
    foodImage = (await photo?.readAsBytes())!;
    notifyListeners();
    return foodImage;
  }

  void buttonSelection() {
    _state = state.copyWith(selected: !_state.selected);
    notifyListeners();
  }
}
