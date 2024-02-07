// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'discard_foods_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DiscardFoodsState _$DiscardFoodsStateFromJson(Map<String, dynamic> json) {
  return _DiscardFoodsState.fromJson(json);
}

/// @nodoc
mixin _$DiscardFoodsState {
  List<FoodDetail> get discardFoodsDetails =>
      throw _privateConstructorUsedError;
  List<RefrigeDetail> get refrigeDetails => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiscardFoodsStateCopyWith<DiscardFoodsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiscardFoodsStateCopyWith<$Res> {
  factory $DiscardFoodsStateCopyWith(
          DiscardFoodsState value, $Res Function(DiscardFoodsState) then) =
      _$DiscardFoodsStateCopyWithImpl<$Res, DiscardFoodsState>;
  @useResult
  $Res call(
      {List<FoodDetail> discardFoodsDetails,
      List<RefrigeDetail> refrigeDetails,
      bool isLoading});
}

/// @nodoc
class _$DiscardFoodsStateCopyWithImpl<$Res, $Val extends DiscardFoodsState>
    implements $DiscardFoodsStateCopyWith<$Res> {
  _$DiscardFoodsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discardFoodsDetails = null,
    Object? refrigeDetails = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      discardFoodsDetails: null == discardFoodsDetails
          ? _value.discardFoodsDetails
          : discardFoodsDetails // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      refrigeDetails: null == refrigeDetails
          ? _value.refrigeDetails
          : refrigeDetails // ignore: cast_nullable_to_non_nullable
              as List<RefrigeDetail>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DiscardFoodsStateImplCopyWith<$Res>
    implements $DiscardFoodsStateCopyWith<$Res> {
  factory _$$DiscardFoodsStateImplCopyWith(_$DiscardFoodsStateImpl value,
          $Res Function(_$DiscardFoodsStateImpl) then) =
      __$$DiscardFoodsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FoodDetail> discardFoodsDetails,
      List<RefrigeDetail> refrigeDetails,
      bool isLoading});
}

/// @nodoc
class __$$DiscardFoodsStateImplCopyWithImpl<$Res>
    extends _$DiscardFoodsStateCopyWithImpl<$Res, _$DiscardFoodsStateImpl>
    implements _$$DiscardFoodsStateImplCopyWith<$Res> {
  __$$DiscardFoodsStateImplCopyWithImpl(_$DiscardFoodsStateImpl _value,
      $Res Function(_$DiscardFoodsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? discardFoodsDetails = null,
    Object? refrigeDetails = null,
    Object? isLoading = null,
  }) {
    return _then(_$DiscardFoodsStateImpl(
      discardFoodsDetails: null == discardFoodsDetails
          ? _value._discardFoodsDetails
          : discardFoodsDetails // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      refrigeDetails: null == refrigeDetails
          ? _value._refrigeDetails
          : refrigeDetails // ignore: cast_nullable_to_non_nullable
              as List<RefrigeDetail>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DiscardFoodsStateImpl
    with DiagnosticableTreeMixin
    implements _DiscardFoodsState {
  const _$DiscardFoodsStateImpl(
      {final List<FoodDetail> discardFoodsDetails = const [],
      final List<RefrigeDetail> refrigeDetails = const [],
      this.isLoading = false})
      : _discardFoodsDetails = discardFoodsDetails,
        _refrigeDetails = refrigeDetails;

  factory _$DiscardFoodsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$DiscardFoodsStateImplFromJson(json);

  final List<FoodDetail> _discardFoodsDetails;
  @override
  @JsonKey()
  List<FoodDetail> get discardFoodsDetails {
    if (_discardFoodsDetails is EqualUnmodifiableListView)
      return _discardFoodsDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_discardFoodsDetails);
  }

  final List<RefrigeDetail> _refrigeDetails;
  @override
  @JsonKey()
  List<RefrigeDetail> get refrigeDetails {
    if (_refrigeDetails is EqualUnmodifiableListView) return _refrigeDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_refrigeDetails);
  }

  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'DiscardFoodsState(discardFoodsDetails: $discardFoodsDetails, refrigeDetails: $refrigeDetails, isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'DiscardFoodsState'))
      ..add(DiagnosticsProperty('discardFoodsDetails', discardFoodsDetails))
      ..add(DiagnosticsProperty('refrigeDetails', refrigeDetails))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DiscardFoodsStateImpl &&
            const DeepCollectionEquality()
                .equals(other._discardFoodsDetails, _discardFoodsDetails) &&
            const DeepCollectionEquality()
                .equals(other._refrigeDetails, _refrigeDetails) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_discardFoodsDetails),
      const DeepCollectionEquality().hash(_refrigeDetails),
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DiscardFoodsStateImplCopyWith<_$DiscardFoodsStateImpl> get copyWith =>
      __$$DiscardFoodsStateImplCopyWithImpl<_$DiscardFoodsStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DiscardFoodsStateImplToJson(
      this,
    );
  }
}

abstract class _DiscardFoodsState implements DiscardFoodsState {
  const factory _DiscardFoodsState(
      {final List<FoodDetail> discardFoodsDetails,
      final List<RefrigeDetail> refrigeDetails,
      final bool isLoading}) = _$DiscardFoodsStateImpl;

  factory _DiscardFoodsState.fromJson(Map<String, dynamic> json) =
      _$DiscardFoodsStateImpl.fromJson;

  @override
  List<FoodDetail> get discardFoodsDetails;
  @override
  List<RefrigeDetail> get refrigeDetails;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$DiscardFoodsStateImplCopyWith<_$DiscardFoodsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
