import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:leute/data/models/user_model.dart';

part 'main_screen_state.freezed.dart';

part 'main_screen_state.g.dart';

@freezed
class MainScreenState with _$MainScreenState {
  const factory MainScreenState({
    UserModel? currentUser,
    @Default(false) bool isLoading,
    @Default(false) bool disposed,
  }) = _MainScreenState;

  factory MainScreenState.fromJson(Map<String, Object?> json) =>
      _$MainScreenStateFromJson(json);
}
