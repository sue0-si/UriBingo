// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'discard_foods_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DiscardFoodsStateImpl _$$DiscardFoodsStateImplFromJson(
        Map<String, dynamic> json) =>
    _$DiscardFoodsStateImpl(
      discardFoodsDetails: (json['discardFoodsDetails'] as List<dynamic>?)
              ?.map((e) => FoodDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      refrigeDetails: (json['refrigeDetails'] as List<dynamic>?)
              ?.map((e) => RefrigeDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$DiscardFoodsStateImplToJson(
        _$DiscardFoodsStateImpl instance) =>
    <String, dynamic>{
      'discardFoodsDetails': instance.discardFoodsDetails,
      'refrigeDetails': instance.refrigeDetails,
      'isLoading': instance.isLoading,
    };
