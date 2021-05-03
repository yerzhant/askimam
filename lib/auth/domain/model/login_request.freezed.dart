// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'login_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) {
  return _LoginRequest.fromJson(json);
}

/// @nodoc
class _$LoginRequestTearOff {
  const _$LoginRequestTearOff();

  _LoginRequest call(String login, String password, String fcmToken) {
    return _LoginRequest(
      login,
      password,
      fcmToken,
    );
  }

  LoginRequest fromJson(Map<String, Object> json) {
    return LoginRequest.fromJson(json);
  }
}

/// @nodoc
const $LoginRequest = _$LoginRequestTearOff();

/// @nodoc
mixin _$LoginRequest {
  String get login => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LoginRequestCopyWith<LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginRequestCopyWith<$Res> {
  factory $LoginRequestCopyWith(
          LoginRequest value, $Res Function(LoginRequest) then) =
      _$LoginRequestCopyWithImpl<$Res>;
  $Res call({String login, String password, String fcmToken});
}

/// @nodoc
class _$LoginRequestCopyWithImpl<$Res> implements $LoginRequestCopyWith<$Res> {
  _$LoginRequestCopyWithImpl(this._value, this._then);

  final LoginRequest _value;
  // ignore: unused_field
  final $Res Function(LoginRequest) _then;

  @override
  $Res call({
    Object? login = freezed,
    Object? password = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      login: login == freezed
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LoginRequestCopyWith<$Res>
    implements $LoginRequestCopyWith<$Res> {
  factory _$LoginRequestCopyWith(
          _LoginRequest value, $Res Function(_LoginRequest) then) =
      __$LoginRequestCopyWithImpl<$Res>;
  @override
  $Res call({String login, String password, String fcmToken});
}

/// @nodoc
class __$LoginRequestCopyWithImpl<$Res> extends _$LoginRequestCopyWithImpl<$Res>
    implements _$LoginRequestCopyWith<$Res> {
  __$LoginRequestCopyWithImpl(
      _LoginRequest _value, $Res Function(_LoginRequest) _then)
      : super(_value, (v) => _then(v as _LoginRequest));

  @override
  _LoginRequest get _value => super._value as _LoginRequest;

  @override
  $Res call({
    Object? login = freezed,
    Object? password = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_LoginRequest(
      login == freezed
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_LoginRequest extends _LoginRequest {
  _$_LoginRequest(this.login, this.password, this.fcmToken) : super._();

  factory _$_LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_LoginRequestFromJson(json);

  @override
  final String login;
  @override
  final String password;
  @override
  final String fcmToken;

  @override
  String toString() {
    return 'LoginRequest(login: $login, password: $password, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoginRequest &&
            (identical(other.login, login) ||
                const DeepCollectionEquality().equals(other.login, login)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)) &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality()
                    .equals(other.fcmToken, fcmToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(login) ^
      const DeepCollectionEquality().hash(password) ^
      const DeepCollectionEquality().hash(fcmToken);

  @JsonKey(ignore: true)
  @override
  _$LoginRequestCopyWith<_LoginRequest> get copyWith =>
      __$LoginRequestCopyWithImpl<_LoginRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LoginRequestToJson(this);
  }
}

abstract class _LoginRequest extends LoginRequest {
  factory _LoginRequest(String login, String password, String fcmToken) =
      _$_LoginRequest;
  _LoginRequest._() : super._();

  factory _LoginRequest.fromJson(Map<String, dynamic> json) =
      _$_LoginRequest.fromJson;

  @override
  String get login => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  String get fcmToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LoginRequestCopyWith<_LoginRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
