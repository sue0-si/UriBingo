import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/user_model.dart';

part 'group_setting_state.freezed.dart';
part 'group_setting_state.g.dart';

@freezed
class GroupSettingState with _$GroupSettingState {
  const factory GroupSettingState({

    @Default([]) List<UserModel> fetchedUserList,
    @Default([]) List<UserModel> addTargetMember,
    @Default(false) bool isMember,
    @Default(false) bool isLoading,
  }) = _GroupSettingState;

  factory GroupSettingState.fromJson(Map<String, Object?> json) =>
      _$GroupSettingStateFromJson(json);
}
