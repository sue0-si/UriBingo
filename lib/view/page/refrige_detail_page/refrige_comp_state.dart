import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/foods_model.dart';

part 'refrige_comp_state.freezed.dart';

part 'refrige_comp_state.g.dart';

@freezed
class RefrigeCompState with _$RefrigeCompState {
  const factory RefrigeCompState({
    @Default([]) List<FoodDetail> foodItems,
    @Default(false) bool isManager,
    @Default(false) bool isLoading,
  }) = _RefrigeCompState;

  factory RefrigeCompState.fromJson(Map<String, Object?> json) =>
      _$RefrigeCompStateFromJson(json);
}
