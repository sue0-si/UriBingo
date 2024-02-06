import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:leute/data/models/foods_model.dart';
import 'package:leute/data/models/refrige_model.dart';

part 'my_fridge_state.freezed.dart';

part 'my_fridge_state.g.dart';

@freezed
class MyFridgeState with _$MyFridgeState {
  const factory MyFridgeState({
    @Default([]) List<FoodDetail> myFoodDetails,
    @Default([]) List<RefrigeDetail> refrigeDetails,
    @Default(false) bool disposed,
    @Default(false) bool isLoading,
  }) = _MyFridgeState;

  factory MyFridgeState.fromJson(Map<String, Object?> json) =>
      _$MyFridgeStateFromJson(json);
}
