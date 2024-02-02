import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewModel extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  bool _selected = false;
  int selectedIndex = 0;
  late Uint8List foodImage;
  bool isLoading = false;

  bool get selected => _selected;

  void changeLoadingState() {
    isLoading = !isLoading;
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

  // Future<void> changeImageFormat() async {
  //   final resultImage = await pickImage();
  //   if (resultImage != null) {
  //     _foodImage = resultImage;
  //   } else {
  //
  //   }
  //   notifyListeners();
  // }

  void buttonSelection(int index) {
    _selected = !_selected;
    notifyListeners();
  }
}
