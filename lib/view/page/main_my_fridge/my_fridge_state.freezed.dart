// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_fridge_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MyFridgeState _$MyFridgeStateFromJson(Map<String, dynamic> json) {
  return _MyFridgeState.fromJson(json);
}

/// @nodoc
mixin _$MyFridgeState {
  List<FoodDetail> get myFoodDetails => throw _privateConstructorUsedError;
  List<RefrigeDetail> get refrigeDetails => throw _privateConstructorUsedError;
  bool get disposed => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MyFridgeStateCopyWith<MyFridgeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyFridgeStateCopyWith<$Res> {
  factory $MyFridgeStateCopyWith(
          MyFridgeState value, $Res Function(MyFridgeState) then) =
      _$MyFridgeStateCopyWithImpl<$Res, MyFridgeState>;
  @useResult
  $Res call(
      {List<FoodDetail> myFoodDetails,
      List<RefrigeDetail> refrigeDetails,
      bool disposed,
      bool isLoading});
}

/// @nodoc
class _$MyFridgeStateCopyWithImpl<$Res, $Val extends MyFridgeState>
    implements $MyFridgeStateCopyWith<$Res> {
  _$MyFridgeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myFoodDetails = null,
    Object? refrigeDetails = null,
    Object? disposed = null,
    Object? isLoading = null,
  }) {
    return _then(_value.copyWith(
      myFoodDetails: null == myFoodDetails
          ? _value.myFoodDetails
          : myFoodDetails // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      refrigeDetails: null == refrigeDetails
          ? _value.refrigeDetails
          : refrigeDetails // ignore: cast_nullable_to_non_nullable
              as List<RefrigeDetail>,
      disposed: null == disposed
          ? _value.disposed
          : disposed // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MyFridgeStateImplCopyWith<$Res>
    implements $MyFridgeStateCopyWith<$Res> {
  factory _$$MyFridgeStateImplCopyWith(
          _$MyFridgeStateImpl value, $Res Function(_$MyFridgeStateImpl) then) =
      __$$MyFridgeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<FoodDetail> myFoodDetails,
      List<RefrigeDetail> refrigeDetails,
      bool disposed,
      bool isLoading});
}

/// @nodoc
class __$$MyFridgeStateImplCopyWithImpl<$Res>
    extends _$MyFridgeStateCopyWithImpl<$Res, _$MyFridgeStateImpl>
    implements _$$MyFridgeStateImplCopyWith<$Res> {
  __$$MyFridgeStateImplCopyWithImpl(
      _$MyFridgeStateImpl _value, $Res Function(_$MyFridgeStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? myFoodDetails = null,
    Object? refrigeDetails = null,
    Object? disposed = null,
    Object? isLoading = null,
  }) {
    return _then(_$MyFridgeStateImpl(
      myFoodDetails: null == myFoodDetails
          ? _value._myFoodDetails
          : myFoodDetails // ignore: cast_nullable_to_non_nullable
              as List<FoodDetail>,
      refrigeDetails: null == refrigeDetails
          ? _value._refrigeDetails
          : refrigeDetails // ignore: cast_nullable_to_non_nullable
              as List<RefrigeDetail>,
      disposed: null == disposed
          ? _value.disposed
          : disposed // ignore: cast_nullable_to_non_nullable
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
class _$MyFridgeStateImpl
    with DiagnosticableTreeMixin
    implements _MyFridgeState {
  const _$MyFridgeStateImpl(
      {final List<FoodDetail> myFoodDetails = const [],
      final List<RefrigeDetail> refrigeDetails = const [],
      this.disposed = false,
      this.isLoading = false})
      : _myFoodDetails = myFoodDetails,
        _refrigeDetails = refrigeDetails;

  factory _$MyFridgeStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MyFridgeStateImplFromJson(json);

  final List<FoodDetail> _myFoodDetails;
  @override
  @JsonKey()
  List<FoodDetail> get myFoodDetails {
    if (_myFoodDetails is EqualUnmodifiableListView) return _myFoodDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_myFoodDetails);
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
  final bool disposed;
  @override
  @JsonKey()
  final bool isLoading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyFridgeState(myFoodDetails: $myFoodDetails, refrigeDetails: $refrigeDetails, disposed: $disposed, isLoading: $isLoading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyFridgeState'))
      ..add(DiagnosticsProperty('myFoodDetails', myFoodDetails))
      ..add(DiagnosticsProperty('refrigeDetails', refrigeDetails))
      ..add(DiagnosticsProperty('disposed', disposed))
      ..add(DiagnosticsProperty('isLoading', isLoading));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MyFridgeStateImpl &&
            const DeepCollectionEquality()
                .equals(other._myFoodDetails, _myFoodDetails) &&
            const DeepCollectionEquality()
                .equals(other._refrigeDetails, _refrigeDetails) &&
            (identical(other.disposed, disposed) ||
                other.disposed == disposed) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_myFoodDetails),
      const DeepCollectionEquality().hash(_refrigeDetails),
      disposed,
      isLoading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MyFridgeStateImplCopyWith<_$MyFridgeStateImpl> get copyWith =>
      __$$MyFridgeStateImplCopyWithImpl<_$MyFridgeStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MyFridgeStateImplToJson(
      this,
    );
  }
}

abstract class _MyFridgeState implements MyFridgeState {
  const factory _MyFridgeState(
      {final List<FoodDetail> myFoodDetails,
      final List<RefrigeDetail> refrigeDetails,
      final bool disposed,
      final bool isLoading}) = _$MyFridgeStateImpl;

  factory _MyFridgeState.fromJson(Map<String, dynamic> json) =
      _$MyFridgeStateImpl.fromJson;

  @override
  List<FoodDetail> get myFoodDetails;
  @override
  List<RefrigeDetail> get refrigeDetails;
  @override
  bool get disposed;
  @override
  bool get isLoading;
  @override
  @JsonKey(ignore: true)
  _$$MyFridgeStateImplCopyWith<_$MyFridgeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
