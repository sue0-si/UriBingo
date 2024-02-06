import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/foods_model.dart';

part 'freezer_comp_state.freezed.dart';

part 'freezer_comp_state.g.dart';

@freezed
class FreezerCompState with _$FreezerCompState {
  const factory FreezerCompState({
    @Default([]) List<FoodDetail> foodItems,
    @Default(false) bool isManager,
    @Default(false) bool isLoading,
  }) = _FreezerCompState;

  factory FreezerCompState.fromJson(Map<String, Object?> json) =>
      _$FreezerCompStateFromJson(json);
}
