// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'rejection_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RejectionExceptionTearOff {
  const _$RejectionExceptionTearOff();

  _RejectionException call(Rejection rejection) {
    return _RejectionException(
      rejection,
    );
  }
}

/// @nodoc
const $RejectionException = _$RejectionExceptionTearOff();

/// @nodoc
mixin _$RejectionException {
  Rejection get rejection => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RejectionExceptionCopyWith<RejectionException> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RejectionExceptionCopyWith<$Res> {
  factory $RejectionExceptionCopyWith(
          RejectionException value, $Res Function(RejectionException) then) =
      _$RejectionExceptionCopyWithImpl<$Res>;
  $Res call({Rejection rejection});

  $RejectionCopyWith<$Res> get rejection;
}

/// @nodoc
class _$RejectionExceptionCopyWithImpl<$Res>
    implements $RejectionExceptionCopyWith<$Res> {
  _$RejectionExceptionCopyWithImpl(this._value, this._then);

  final RejectionException _value;
  // ignore: unused_field
  final $Res Function(RejectionException) _then;

  @override
  $Res call({
    Object? rejection = freezed,
  }) {
    return _then(_value.copyWith(
      rejection: rejection == freezed
          ? _value.rejection
          : rejection // ignore: cast_nullable_to_non_nullable
              as Rejection,
    ));
  }

  @override
  $RejectionCopyWith<$Res> get rejection {
    return $RejectionCopyWith<$Res>(_value.rejection, (value) {
      return _then(_value.copyWith(rejection: value));
    });
  }
}

/// @nodoc
abstract class _$RejectionExceptionCopyWith<$Res>
    implements $RejectionExceptionCopyWith<$Res> {
  factory _$RejectionExceptionCopyWith(
          _RejectionException value, $Res Function(_RejectionException) then) =
      __$RejectionExceptionCopyWithImpl<$Res>;
  @override
  $Res call({Rejection rejection});

  @override
  $RejectionCopyWith<$Res> get rejection;
}

/// @nodoc
class __$RejectionExceptionCopyWithImpl<$Res>
    extends _$RejectionExceptionCopyWithImpl<$Res>
    implements _$RejectionExceptionCopyWith<$Res> {
  __$RejectionExceptionCopyWithImpl(
      _RejectionException _value, $Res Function(_RejectionException) _then)
      : super(_value, (v) => _then(v as _RejectionException));

  @override
  _RejectionException get _value => super._value as _RejectionException;

  @override
  $Res call({
    Object? rejection = freezed,
  }) {
    return _then(_RejectionException(
      rejection == freezed
          ? _value.rejection
          : rejection // ignore: cast_nullable_to_non_nullable
              as Rejection,
    ));
  }
}

/// @nodoc
class _$_RejectionException implements _RejectionException {
  _$_RejectionException(this.rejection);

  @override
  final Rejection rejection;

  @override
  String toString() {
    return 'RejectionException(rejection: $rejection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RejectionException &&
            (identical(other.rejection, rejection) ||
                const DeepCollectionEquality()
                    .equals(other.rejection, rejection)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(rejection);

  @JsonKey(ignore: true)
  @override
  _$RejectionExceptionCopyWith<_RejectionException> get copyWith =>
      __$RejectionExceptionCopyWithImpl<_RejectionException>(this, _$identity);
}

abstract class _RejectionException implements RejectionException {
  factory _RejectionException(Rejection rejection) = _$_RejectionException;

  @override
  Rejection get rejection => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RejectionExceptionCopyWith<_RejectionException> get copyWith =>
      throw _privateConstructorUsedError;
}
