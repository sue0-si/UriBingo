// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freezer_comp_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FreezerCompStateImpl _$$FreezerCompStateImplFromJson(
        Map<String, dynamic> json) =>
    _$FreezerCompStateImpl(
      foodItems: (json['foodItems'] as List<dynamic>?)
              ?.map((e) => FoodDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isManager: json['isManager'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$FreezerCompStateImplToJson(
        _$FreezerCompStateImpl instance) =>
    <String, dynamic>{
      'foodItems': instance.foodItems,
      'isManager': instance.isManager,
      'isLoading': instance.isLoading,
    };
