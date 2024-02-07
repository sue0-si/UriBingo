import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/foods_model.dart';

part 'refrige_state.freezed.dart';

part 'refrige_state.g.dart';

@freezed
class RefrigeState with _$RefrigeState {
  factory RefrigeState({
    @Default([]) List<FoodDetail> foodItems,
    @Default('') String name,
    @Default('0 칸') String selectedColdstorage, //선택된냉장칸수
    @Default('0 칸') String selectedFrozenStorage,
    @Default('1 일') String selectedStoragePeriod,
    @Default('1 일') String selectedExtensionPeriod,//선택된연장가능기간
    @Default(0) int registerdDate,
    @Default('') String initialName,
  }) = _RefrigeState;

  factory RefrigeState.fromJson(Map<String, dynamic> json) =>
      _$RefrigeStateFromJson(json);
}
