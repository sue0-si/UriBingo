import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';


import '../../../data/models/foods_model.dart';
import '../../../data/models/refrige_model.dart';

part 'discard_foods_state.freezed.dart';
part 'discard_foods_state.g.dart';

@freezed
class DiscardFoodsState with _$DiscardFoodsState {
  const factory DiscardFoodsState({
    @Default([]) List<FoodDetail> discardFoodsDetails,
    @Default([]) List<RefrigeDetail> refrigeDetails,
    @Default(false) bool isLoading,
  }) = _DiscardFoodsState;

  factory DiscardFoodsState.fromJson(Map<String, Object?> json) =>
      _$DiscardFoodsStateFromJson(json);
}
