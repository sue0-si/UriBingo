import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:leute/data/models/refrige_model.dart';
import 'package:leute/data/models/user_model.dart';

part 'main_screen_state.freezed.dart';

part 'main_screen_state.g.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    @Default([]) List<RefrigeDetail> refrigeItems,
    UserModel? currentUser,
    @Default(false) bool isLoading,
  }) = _MainScreenState;

  factory MainScreenState.fromJson(Map<String, Object?> json) =>
      _$MainScreenStateFromJson(json);
}
