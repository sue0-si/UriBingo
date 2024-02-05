// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_food_detail_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MyFoodDetailStateImpl _$$MyFoodDetailStateImplFromJson(
        Map<String, dynamic> json) =>
    _$MyFoodDetailStateImpl(
      (json['foodDetails'] as List<dynamic>)
          .map((e) => FoodDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['remainPeriod'] as int,
      json['isOld'] as bool,
    );

Map<String, dynamic> _$$MyFoodDetailStateImplToJson(
        _$MyFoodDetailStateImpl instance) =>
    <String, dynamic>{
      'foodDetails': instance.foodDetails,
      'remainPeriod': instance.remainPeriod,
      'isOld': instance.isOld,
    };
