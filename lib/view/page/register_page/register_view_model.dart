import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leute/view/page/register_page/register_state.dart';

class RegisterViewModel extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  late Uint8List foodImage;

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