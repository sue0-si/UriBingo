// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_fridge_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyFridgeStateImpl _$$MyFridgeStateImplFromJson(Map<String, dynamic> json) =>
    _$MyFridgeStateImpl(
      myFoodDetails: (json['myFoodDetails'] as List<dynamic>?)
              ?.map((e) => FoodDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      refrigeDetails: (json['refrigeDetails'] as List<dynamic>?)
              ?.map((e) => RefrigeDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      disposed: json['disposed'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$MyFridgeStateImplToJson(_$MyFridgeStateImpl instance) =>
    <String, dynamic>{
      'myFoodDetails': instance.myFoodDetails,
      'refrigeDetails': instance.refrigeDetails,
      'disposed': instance.disposed,
      'isLoading': instance.isLoading,
    };
