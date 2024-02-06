// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_screen_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MainScreenStateImpl _$$MainScreenStateImplFromJson(
        Map<String, dynamic> json) =>
    _$MainScreenStateImpl(
      refrigeItems: (json['refrigeItems'] as List<dynamic>?)
              ?.map((e) => RefrigeDetail.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentUser: json['currentUser'] == null
          ? null
          : UserModel.fromJson(json['currentUser'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$MainScreenStateImplToJson(
        _$MainScreenStateImpl instance) =>
    <String, dynamic>{
      'refrigeItems': instance.refrigeItems,
      'currentUser': instance.currentUser,
      'isLoading': instance.isLoading,
    };
