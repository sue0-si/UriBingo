// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refrige_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RefrigeStateImpl _$$RefrigeStateImplFromJson(Map<String, dynamic> json) =>
    _$RefrigeStateImpl(
      foodItems: (json['foodItems'] as List<dynamic>?)
              ?.map((e) => FoodDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      name: json['name'] as String? ?? '',
      selectedColdstorage: json['selectedColdstorage'] as String? ?? '0 칸',
      selectedFrozenStorage: json['selectedFrozenStorage'] as String? ?? '0 칸',
      selectedStoragePeriod: json['selectedStoragePeriod'] as String? ?? '1 일',
      selectedExtensionPeriod:
          json['selectedExtensionPeriod'] as String? ?? '1 일',
      registerdDate: json['registerdDate'] as int? ?? 0,
      initialName: json['initialName'] as String? ?? '',
    );

Map<String, dynamic> _$$RefrigeStateImplToJson(_$RefrigeStateImpl instance) =>
    <String, dynamic>{
      'foodItems': instance.foodItems,
      'name': instance.name,
      'selectedColdstorage': instance.selectedColdstorage,
      'selectedFrozenStorage': instance.selectedFrozenStorage,
      'selectedStoragePeriod': instance.selectedStoragePeriod,
      'selectedExtensionPeriod': instance.selectedExtensionPeriod,
      'registerdDate': instance.registerdDate,
      'initialName': instance.initialName,
    };
