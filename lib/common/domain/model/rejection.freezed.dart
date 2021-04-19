// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'rejection.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$RejectionTearOff {
  const _$RejectionTearOff();

  _Rejection call(String reason) {
    return _Rejection(
      reason,
    );
  }
}

/// @nodoc
const $Rejection = _$RejectionTearOff();

/// @nodoc
mixin _$Rejection {
  String get reason => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RejectionCopyWith<Rejection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RejectionCopyWith<$Res> {
  factory $RejectionCopyWith(Rejection value, $Res Function(Rejection) then) =
      _$RejectionCopyWithImpl<$Res>;
  $Res call({String reason});
}

/// @nodoc
class _$RejectionCopyWithImpl<$Res> implements $RejectionCopyWith<$Res> {
  _$RejectionCopyWithImpl(this._value, this._then);

  final Rejection _value;
  // ignore: unused_field
  final $Res Function(Rejection) _then;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_value.copyWith(
      reason: reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$RejectionCopyWith<$Res> implements $RejectionCopyWith<$Res> {
  factory _$RejectionCopyWith(
          _Rejection value, $Res Function(_Rejection) then) =
      __$RejectionCopyWithImpl<$Res>;
  @override
  $Res call({String reason});
}

/// @nodoc
class __$RejectionCopyWithImpl<$Res> extends _$RejectionCopyWithImpl<$Res>
    implements _$RejectionCopyWith<$Res> {
  __$RejectionCopyWithImpl(_Rejection _value, $Res Function(_Rejection) _then)
      : super(_value, (v) => _then(v as _Rejection));

  @override
  _Rejection get _value => super._value as _Rejection;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(_Rejection(
      reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_Rejection implements _Rejection {
  _$_Rejection(this.reason)
      : assert(reason.trim().isNotEmpty, 'reason may not be empty');

  @override
  final String reason;

  @override
  String toString() {
    return 'Rejection(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Rejection &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reason);

  @JsonKey(ignore: true)
  @override
  _$RejectionCopyWith<_Rejection> get copyWith =>
      __$RejectionCopyWithImpl<_Rejection>(this, _$identity);
}

abstract class _Rejection implements Rejection {
  factory _Rejection(String reason) = _$_Rejection;

  @override
  String get reason => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$RejectionCopyWith<_Rejection> get copyWith =>
      throw _privateConstructorUsedError;
}
