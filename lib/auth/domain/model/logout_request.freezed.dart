// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'logout_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LogoutRequest _$LogoutRequestFromJson(Map<String, dynamic> json) {
  return _LogoutRequest.fromJson(json);
}

/// @nodoc
class _$LogoutRequestTearOff {
  const _$LogoutRequestTearOff();

  _LogoutRequest call(String fcmToken) {
    return _LogoutRequest(
      fcmToken,
    );
  }

  LogoutRequest fromJson(Map<String, Object> json) {
    return LogoutRequest.fromJson(json);
  }
}

/// @nodoc
const $LogoutRequest = _$LogoutRequestTearOff();

/// @nodoc
mixin _$LogoutRequest {
  String get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LogoutRequestCopyWith<LogoutRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogoutRequestCopyWith<$Res> {
  factory $LogoutRequestCopyWith(
          LogoutRequest value, $Res Function(LogoutRequest) then) =
      _$LogoutRequestCopyWithImpl<$Res>;
  $Res call({String fcmToken});
}

/// @nodoc
class _$LogoutRequestCopyWithImpl<$Res>
    implements $LogoutRequestCopyWith<$Res> {
  _$LogoutRequestCopyWithImpl(this._value, this._then);

  final LogoutRequest _value;
  // ignore: unused_field
  final $Res Function(LogoutRequest) _then;

  @override
  $Res call({
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LogoutRequestCopyWith<$Res>
    implements $LogoutRequestCopyWith<$Res> {
  factory _$LogoutRequestCopyWith(
          _LogoutRequest value, $Res Function(_LogoutRequest) then) =
      __$LogoutRequestCopyWithImpl<$Res>;
  @override
  $Res call({String fcmToken});
}

/// @nodoc
class __$LogoutRequestCopyWithImpl<$Res>
    extends _$LogoutRequestCopyWithImpl<$Res>
    implements _$LogoutRequestCopyWith<$Res> {
  __$LogoutRequestCopyWithImpl(
      _LogoutRequest _value, $Res Function(_LogoutRequest) _then)
      : super(_value, (v) => _then(v as _LogoutRequest));

  @override
  _LogoutRequest get _value => super._value as _LogoutRequest;

  @override
  $Res call({
    Object? fcmToken = freezed,
  }) {
    return _then(_LogoutRequest(
      fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_LogoutRequest extends _LogoutRequest {
  _$_LogoutRequest(this.fcmToken) : super._();

  factory _$_LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_LogoutRequestFromJson(json);

  @override
  final String fcmToken;

  @override
  String toString() {
    return 'LogoutRequest(fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LogoutRequest &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality()
                    .equals(other.fcmToken, fcmToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(fcmToken);

  @JsonKey(ignore: true)
  @override
  _$LogoutRequestCopyWith<_LogoutRequest> get copyWith =>
      __$LogoutRequestCopyWithImpl<_LogoutRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LogoutRequestToJson(this);
  }
}

abstract class _LogoutRequest extends LogoutRequest {
  factory _LogoutRequest(String fcmToken) = _$_LogoutRequest;
  _LogoutRequest._() : super._();

  factory _LogoutRequest.fromJson(Map<String, dynamic> json) =
      _$_LogoutRequest.fromJson;

  @override
  String get fcmToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LogoutRequestCopyWith<_LogoutRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
