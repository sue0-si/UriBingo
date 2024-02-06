// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_setting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupSettingState _$GroupSettingStateFromJson(Map<String, dynamic> json) {
  return _GroupSettingState.fromJson(json);
}

/// @nodoc
mixin _$GroupSettingState {
  List<UserModel> get fetchedUserList => throw _privateConstructorUsedError;
  List<UserModel> get unavailableList => throw _privateConstructorUsedError;
  List<UserModel> get addTargetMember => throw _privateConstructorUsedError;
  bool get isMember => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupSettingStateCopyWith<GroupSettingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupSettingStateCopyWith<$Res> {
  factory $GroupSettingStateCopyWith(
          GroupSettingState value, $Res Function(GroupSettingState) then) =
      _$GroupSettingStateCopyWithImpl<$Res, GroupSettingState>;
  @useResult
  $Res call(
      {List<UserModel> fetchedUserList,
      List<UserModel> unavailableList,
      List<UserModel> addTargetMember,
      bool isMember,
      bool isLoading});
}

/// @nodoc
class _$GroupSettingStateCopyWithImpl<$Res, $Val extends GroupSettingState>
    implements $GroupSettingStateCopyWith<$Res> {
  _$GroupSettingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetchedUserList = null,
    Object? unavailableList = null,
    Object? addTargetMember = null,
    Object? isMember = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      fetchedUserList: null == fetchedUserList
          ? _value.fetchedUserList
          : fetchedUserList // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      unavailableList: null == unavailableList
          ? _value.unavailableList
          : unavailableList // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      addTargetMember: null == addTargetMember
          ? _value.addTargetMember
          : addTargetMember // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      isMember: null == isMember
          ? _value.isMember
          : isMember // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupSettingStateImplCopyWith<$Res>
    implements $GroupSettingStateCopyWith<$Res> {
  factory _$$GroupSettingStateImplCopyWith(_$GroupSettingStateImpl value,
          $Res Function(_$GroupSettingStateImpl) then) =
      __$$GroupSettingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<UserModel> fetchedUserList,
      List<UserModel> unavailableList,
      List<UserModel> addTargetMember,
      bool isMember,
      bool isLoading});
}

/// @nodoc
class __$$GroupSettingStateImplCopyWithImpl<$Res>
    extends _$GroupSettingStateCopyWithImpl<$Res, _$GroupSettingStateImpl>
    implements _$$GroupSettingStateImplCopyWith<$Res> {
  __$$GroupSettingStateImplCopyWithImpl(_$GroupSettingStateImpl _value,
      $Res Function(_$GroupSettingStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fetchedUserList = null,
    Object? unavailableList = null,
    Object? addTargetMember = null,
    Object? isMember = null,
    Object? isLoading = null,
  }) {
    return _then(_$GroupSettingStateImpl(
      fetchedUserList: null == fetchedUserList
          ? _value._fetchedUserList
          : fetchedUserList // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      unavailableList: null == unavailableList
          ? _value._unavailableList
          : unavailableList // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      addTargetMember: null == addTargetMember
          ? _value._addTargetMember
          : addTargetMember // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
      isMember: null == isMember
          ? _value.isMember
          : isMember // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupSettingStateImpl
    with DiagnosticableTreeMixin
    implements _GroupSettingState {
  const _$GroupSettingStateImpl(
      {final List<UserModel> fetchedUserList = const [],
      final List<UserModel> unavailableList = const [],
      final List<UserModel> addTargetMember = const [],
      this.isMember = false,
      this.isLoading = false})
      : _fetchedUserList = fetchedUserList,
        _unavailableList = unavailableList,
        _addTargetMember = addTargetMember;

  factory _$GroupSettingStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupSettingStateImplFromJson(json);

  final List<UserModel> _fetchedUserList;
  @override
  @JsonKey()
  List<UserModel> get fetchedUserList {
    if (_fetchedUserList is EqualUnmodifiableListView) return _fetchedUserList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fetchedUserList);
  }

  final List<UserModel> _unavailableList;
  @override
  @JsonKey()
  List<UserModel> get unavailableList {
    if (_unavailableList is EqualUnmodifiableListView) return _unavailableList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unavailableList);
  }

  final List<UserModel> _addTargetMember;
  @override
  @JsonKey()
  List<UserModel> get addTargetMember {
    if (_addTargetMember is EqualUnmodifiableListView) return _addTargetMember;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_addTargetMember);
  }

  @override
  @JsonKey()
  final bool isMember;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GroupSettingState(fetchedUserList: $fetchedUserList, unavailableList: $unavailableList, addTargetMember: $addTargetMember, isMember: $isMember, isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GroupSettingState'))
      ..add(DiagnosticsProperty('fetchedUserList', fetchedUserList))
      ..add(DiagnosticsProperty('unavailableList', unavailableList))
      ..add(DiagnosticsProperty('addTargetMember', addTargetMember))
      ..add(DiagnosticsProperty('isMember', isMember))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupSettingStateImpl &&
            const DeepCollectionEquality()
                .equals(other._fetchedUserList, _fetchedUserList) &&
            const DeepCollectionEquality()
                .equals(other._unavailableList, _unavailableList) &&
            const DeepCollectionEquality()
                .equals(other._addTargetMember, _addTargetMember) &&
            (identical(other.isMember, isMember) ||
                other.isMember == isMember) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_fetchedUserList),
      const DeepCollectionEquality().hash(_unavailableList),
      const DeepCollectionEquality().hash(_addTargetMember),
      isMember,
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupSettingStateImplCopyWith<_$GroupSettingStateImpl> get copyWith =>
      __$$GroupSettingStateImplCopyWithImpl<_$GroupSettingStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupSettingStateImplToJson(
      this,
    );
  }
}

abstract class _GroupSettingState implements GroupSettingState {
  const factory _GroupSettingState(
      {final List<UserModel> fetchedUserList,
      final List<UserModel> unavailableList,
      final List<UserModel> addTargetMember,
      final bool isMember,
      final bool isLoading}) = _$GroupSettingStateImpl;

  factory _GroupSettingState.fromJson(Map<String, dynamic> json) =
      _$GroupSettingStateImpl.fromJson;

  @override
  List<UserModel> get fetchedUserList;
  @override
  List<UserModel> get unavailableList;
  @override
  List<UserModel> get addTargetMember;
  @override
  bool get isMember;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$GroupSettingStateImplCopyWith<_$GroupSettingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
