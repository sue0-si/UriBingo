// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_setting_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupSettingStateImpl _$$GroupSettingStateImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupSettingStateImpl(
      fetchedUserList: (json['fetchedUserList'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      unavailableList: (json['unavailableList'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      addTargetMember: (json['addTargetMember'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isMember: json['isMember'] as bool? ?? false,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$GroupSettingStateImplToJson(
        _$GroupSettingStateImpl instance) =>
    <String, dynamic>{
      'fetchedUserList': instance.fetchedUserList,
      'unavailableList': instance.unavailableList,
      'addTargetMember': instance.addTargetMember,
      'isMember': instance.isMember,
      'isLoading': instance.isLoading,
    };
