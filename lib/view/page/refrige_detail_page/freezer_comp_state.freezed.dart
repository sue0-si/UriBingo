// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezer_comp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FreezerCompState _$FreezerCompStateFromJson(Map<String, dynamic> json) {
  return _FreezerCompState.fromJson(json);
}

/// @nodoc
mixin _$FreezerCompState {
  List<FoodDetail> get foodItems => throw _privateConstructorUsedError;
  bool get isManager => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FreezerCompStateCopyWith<FreezerCompState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FreezerCompStateCopyWith<$Res> {
  factory $FreezerCompStateCopyWith(
          FreezerCompState value, $Res Function(FreezerCompState) then) =
      _$FreezerCompStateCopyWithImpl<$Res, FreezerCompState>;
  @useResult
  $Res call({List<FoodDetail> foodItems, bool isManager, bool isLoading});
}

/// @nodoc
class _$FreezerCompStateCopyWithImpl<$Res, $Val extends FreezerCompState>
    implements $FreezerCompStateCopyWith<$Res> {
  _$FreezerCompStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodItems = null,
    Object? isManager = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      foodItems: null == foodItems
          ? _value.foodItems
          : foodItems // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      isManager: null == isManager
          ? _value.isManager
          : isManager // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FreezerCompStateImplCopyWith<$Res>
    implements $FreezerCompStateCopyWith<$Res> {
  factory _$$FreezerCompStateImplCopyWith(_$FreezerCompStateImpl value,
          $Res Function(_$FreezerCompStateImpl) then) =
      __$$FreezerCompStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FoodDetail> foodItems, bool isManager, bool isLoading});
}

/// @nodoc
class __$$FreezerCompStateImplCopyWithImpl<$Res>
    extends _$FreezerCompStateCopyWithImpl<$Res, _$FreezerCompStateImpl>
    implements _$$FreezerCompStateImplCopyWith<$Res> {
  __$$FreezerCompStateImplCopyWithImpl(_$FreezerCompStateImpl _value,
      $Res Function(_$FreezerCompStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodItems = null,
    Object? isManager = null,
    Object? isLoading = null,
  }) {
    return _then(_$FreezerCompStateImpl(
      foodItems: null == foodItems
          ? _value._foodItems
          : foodItems // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      isManager: null == isManager
          ? _value.isManager
          : isManager // ignore: cast_nullable_to_non_nullable
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
class _$FreezerCompStateImpl
    with DiagnosticableTreeMixin
    implements _FreezerCompState {
  const _$FreezerCompStateImpl(
      {final List<FoodDetail> foodItems = const [],
      this.isManager = false,
      this.isLoading = false})
      : _foodItems = foodItems;

  factory _$FreezerCompStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$FreezerCompStateImplFromJson(json);

  final List<FoodDetail> _foodItems;
  @override
  @JsonKey()
  List<FoodDetail> get foodItems {
    if (_foodItems is EqualUnmodifiableListView) return _foodItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodItems);
  }

  @override
  @JsonKey()
  final bool isManager;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FreezerCompState(foodItems: $foodItems, isManager: $isManager, isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FreezerCompState'))
      ..add(DiagnosticsProperty('foodItems', foodItems))
      ..add(DiagnosticsProperty('isManager', isManager))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FreezerCompStateImpl &&
            const DeepCollectionEquality()
                .equals(other._foodItems, _foodItems) &&
            (identical(other.isManager, isManager) ||
                other.isManager == isManager) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_foodItems), isManager, isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FreezerCompStateImplCopyWith<_$FreezerCompStateImpl> get copyWith =>
      __$$FreezerCompStateImplCopyWithImpl<_$FreezerCompStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FreezerCompStateImplToJson(
      this,
    );
  }
}

abstract class _FreezerCompState implements FreezerCompState {
  const factory _FreezerCompState(
      {final List<FoodDetail> foodItems,
      final bool isManager,
      final bool isLoading}) = _$FreezerCompStateImpl;

  factory _FreezerCompState.fromJson(Map<String, dynamic> json) =
      _$FreezerCompStateImpl.fromJson;

  @override
  List<FoodDetail> get foodItems;
  @override
  bool get isManager;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$FreezerCompStateImplCopyWith<_$FreezerCompStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
