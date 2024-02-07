import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'register_state.freezed.dart';

part 'register_state.g.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(false) bool isLoading,
    @Default(false) bool selected,
  }) = _RegisterState;
  
  factory RegisterState.fromJson(Map<String, Object?> json) => _$RegisterStateFromJson(json); 
}