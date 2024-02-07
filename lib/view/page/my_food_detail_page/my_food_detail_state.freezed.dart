// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_food_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyFoodDetailState _$MyFoodDetailStateFromJson(Map<String, dynamic> json) {
  return _MyFoodDetailState.fromJson(json);
}

/// @nodoc
mixin _$MyFoodDetailState {
  List<FoodDetail> get foodDetails => throw _privateConstructorUsedError;
  int get remainPeriod => throw _privateConstructorUsedError;
  bool get isOld => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyFoodDetailStateCopyWith<MyFoodDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyFoodDetailStateCopyWith<$Res> {
  factory $MyFoodDetailStateCopyWith(
          MyFoodDetailState value, $Res Function(MyFoodDetailState) then) =
      _$MyFoodDetailStateCopyWithImpl<$Res, MyFoodDetailState>;
  @useResult
  $Res call({List<FoodDetail> foodDetails, int remainPeriod, bool isOld});
}

/// @nodoc
class _$MyFoodDetailStateCopyWithImpl<$Res, $Val extends MyFoodDetailState>
    implements $MyFoodDetailStateCopyWith<$Res> {
  _$MyFoodDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodDetails = null,
    Object? remainPeriod = null,
    Object? isOld = null,
  }) {
    return _then(_value.copyWith(
      foodDetails: null == foodDetails
          ? _value.foodDetails
          : foodDetails // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      remainPeriod: null == remainPeriod
          ? _value.remainPeriod
          : remainPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      isOld: null == isOld
          ? _value.isOld
          : isOld // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyFoodDetailStateImplCopyWith<$Res>
    implements $MyFoodDetailStateCopyWith<$Res> {
  factory _$$MyFoodDetailStateImplCopyWith(_$MyFoodDetailStateImpl value,
          $Res Function(_$MyFoodDetailStateImpl) then) =
      __$$MyFoodDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<FoodDetail> foodDetails, int remainPeriod, bool isOld});
}

/// @nodoc
class __$$MyFoodDetailStateImplCopyWithImpl<$Res>
    extends _$MyFoodDetailStateCopyWithImpl<$Res, _$MyFoodDetailStateImpl>
    implements _$$MyFoodDetailStateImplCopyWith<$Res> {
  __$$MyFoodDetailStateImplCopyWithImpl(_$MyFoodDetailStateImpl _value,
      $Res Function(_$MyFoodDetailStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodDetails = null,
    Object? remainPeriod = null,
    Object? isOld = null,
  }) {
    return _then(_$MyFoodDetailStateImpl(
      null == foodDetails
          ? _value._foodDetails
          : foodDetails // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      null == remainPeriod
          ? _value.remainPeriod
          : remainPeriod // ignore: cast_nullable_to_non_nullable
              as int,
      null == isOld
          ? _value.isOld
          : isOld // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MyFoodDetailStateImpl implements _MyFoodDetailState {
  _$MyFoodDetailStateImpl(
      final List<FoodDetail> foodDetails, this.remainPeriod, this.isOld)
      : _foodDetails = foodDetails;

  factory _$MyFoodDetailStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyFoodDetailStateImplFromJson(json);

  final List<FoodDetail> _foodDetails;
  @override
  List<FoodDetail> get foodDetails {
    if (_foodDetails is EqualUnmodifiableListView) return _foodDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foodDetails);
  }

  @override
  final int remainPeriod;
  @override
  final bool isOld;

  @override
  String toString() {
    return 'MyFoodDetailState(foodDetails: $foodDetails, remainPeriod: $remainPeriod, isOld: $isOld)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyFoodDetailStateImpl &&
            const DeepCollectionEquality()
                .equals(other._foodDetails, _foodDetails) &&
            (identical(other.remainPeriod, remainPeriod) ||
                other.remainPeriod == remainPeriod) &&
            (identical(other.isOld, isOld) || other.isOld == isOld));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_foodDetails), remainPeriod, isOld);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyFoodDetailStateImplCopyWith<_$MyFoodDetailStateImpl> get copyWith =>
      __$$MyFoodDetailStateImplCopyWithImpl<_$MyFoodDetailStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyFoodDetailStateImplToJson(
      this,
    );
  }
}

abstract class _MyFoodDetailState implements MyFoodDetailState {
  factory _MyFoodDetailState(final List<FoodDetail> foodDetails,
      final int remainPeriod, final bool isOld) = _$MyFoodDetailStateImpl;

  factory _MyFoodDetailState.fromJson(Map<String, dynamic> json) =
      _$MyFoodDetailStateImpl.fromJson;

  @override
  List<FoodDetail> get foodDetails;
  @override
  int get remainPeriod;
  @override
  bool get isOld;
  @override
  @JsonKey(ignore: true)
  _$$MyFoodDetailStateImplCopyWith<_$MyFoodDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
