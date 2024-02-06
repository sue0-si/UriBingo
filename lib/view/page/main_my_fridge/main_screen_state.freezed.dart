// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_screen_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MainScreenState _$MainScreenStateFromJson(Map<String, dynamic> json) {
  return _MainScreenState.fromJson(json);
}

/// @nodoc
mixin _$MainScreenState {
  List<RefrigeDetail> get refrigeItems => throw _privateConstructorUsedError;
  UserModel? get currentUser => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MainScreenStateCopyWith<MainScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainScreenStateCopyWith<$Res> {
  factory $MainScreenStateCopyWith(
          MainScreenState value, $Res Function(MainScreenState) then) =
      _$MainScreenStateCopyWithImpl<$Res, MainScreenState>;
  @useResult
  $Res call(
      {List<RefrigeDetail> refrigeItems,
      UserModel? currentUser,
      bool isLoading});
}

/// @nodoc
class _$MainScreenStateCopyWithImpl<$Res, $Val extends MainScreenState>
    implements $MainScreenStateCopyWith<$Res> {
  _$MainScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refrigeItems = null,
    Object? currentUser = freezed,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      refrigeItems: null == refrigeItems
          ? _value.refrigeItems
          : refrigeItems // ignore: cast_nullable_to_non_nullable
              as List<RefrigeDetail>,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MainScreenStateImplCopyWith<$Res>
    implements $MainScreenStateCopyWith<$Res> {
  factory _$$MainScreenStateImplCopyWith(_$MainScreenStateImpl value,
          $Res Function(_$MainScreenStateImpl) then) =
      __$$MainScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RefrigeDetail> refrigeItems,
      UserModel? currentUser,
      bool isLoading});
}

/// @nodoc
class __$$MainScreenStateImplCopyWithImpl<$Res>
    extends _$MainScreenStateCopyWithImpl<$Res, _$MainScreenStateImpl>
    implements _$$MainScreenStateImplCopyWith<$Res> {
  __$$MainScreenStateImplCopyWithImpl(
      _$MainScreenStateImpl _value, $Res Function(_$MainScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refrigeItems = null,
    Object? currentUser = freezed,
    Object? isLoading = null,
  }) {
    return _then(_$MainScreenStateImpl(
      refrigeItems: null == refrigeItems
          ? _value._refrigeItems
          : refrigeItems // ignore: cast_nullable_to_non_nullable
              as List<RefrigeDetail>,
      currentUser: freezed == currentUser
          ? _value.currentUser
          : currentUser // ignore: cast_nullable_to_non_nullable
              as UserModel?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MainScreenStateImpl implements _MainScreenState {
  const _$MainScreenStateImpl(
      {final List<RefrigeDetail> refrigeItems = const [],
      this.currentUser,
      this.isLoading = false})
      : _refrigeItems = refrigeItems;

  factory _$MainScreenStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MainScreenStateImplFromJson(json);

  final List<RefrigeDetail> _refrigeItems;
  @override
  @JsonKey()
  List<RefrigeDetail> get refrigeItems {
    if (_refrigeItems is EqualUnmodifiableListView) return _refrigeItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refrigeItems);
  }

  @override
  final UserModel? currentUser;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString() {
    return 'MainScreenState(refrigeItems: $refrigeItems, currentUser: $currentUser, isLoading: $isLoading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainScreenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._refrigeItems, _refrigeItems) &&
            (identical(other.currentUser, currentUser) ||
                other.currentUser == currentUser) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_refrigeItems),
      currentUser,
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MainScreenStateImplCopyWith<_$MainScreenStateImpl> get copyWith =>
      __$$MainScreenStateImplCopyWithImpl<_$MainScreenStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MainScreenStateImplToJson(
      this,
    );
  }
}

abstract class _MainScreenState implements MainScreenState {
  const factory _MainScreenState(
      {final List<RefrigeDetail> refrigeItems,
      final UserModel? currentUser,
      final bool isLoading}) = _$MainScreenStateImpl;

  factory _MainScreenState.fromJson(Map<String, dynamic> json) =
      _$MainScreenStateImpl.fromJson;

  @override
  List<RefrigeDetail> get refrigeItems;
  @override
  UserModel? get currentUser;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$MainScreenStateImplCopyWith<_$MainScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
