import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class RegisterViewModel extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  XFile? photo;
  final List<bool> _selected = [false, false];
  int selectedIndex = 0;
  late Uint8List _foodImage;
  bool isLoading = false;

  List<bool> get selected => _selected;

  Uint8List get foodImage => _foodImage;

  void changeLoadingState() {
    isLoading = !isLoading;
    notifyListeners();
  }

  Future<Uint8List?> pickImage() async {
    photo = await picker.pickImage(source: ImageSource.camera);
    notifyListeners();
    return await photo?.readAsBytes();
  }

  Future<void> changeImageFormat() async {
    _foodImage = (await pickImage())!;
  }

  void buttonSelection(int index) {
    for (int i = 0; i < selected.length; i++) {
      selected[i] = i == index;
    }
    notifyListeners();
  }
}
