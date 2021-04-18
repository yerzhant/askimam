// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'authentication_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthenticationRequest _$AuthenticationRequestFromJson(
    Map<String, dynamic> json) {
  return _AuthenticationRequest.fromJson(json);
}

/// @nodoc
class _$AuthenticationRequestTearOff {
  const _$AuthenticationRequestTearOff();

  _AuthenticationRequest call(String login, String password) {
    return _AuthenticationRequest(
      login,
      password,
    );
  }

  AuthenticationRequest fromJson(Map<String, Object> json) {
    return AuthenticationRequest.fromJson(json);
  }
}

/// @nodoc
const $AuthenticationRequest = _$AuthenticationRequestTearOff();

/// @nodoc
mixin _$AuthenticationRequest {
  String get login => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthenticationRequestCopyWith<AuthenticationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthenticationRequestCopyWith<$Res> {
  factory $AuthenticationRequestCopyWith(AuthenticationRequest value,
          $Res Function(AuthenticationRequest) then) =
      _$AuthenticationRequestCopyWithImpl<$Res>;
  $Res call({String login, String password});
}

/// @nodoc
class _$AuthenticationRequestCopyWithImpl<$Res>
    implements $AuthenticationRequestCopyWith<$Res> {
  _$AuthenticationRequestCopyWithImpl(this._value, this._then);

  final AuthenticationRequest _value;
  // ignore: unused_field
  final $Res Function(AuthenticationRequest) _then;

  @override
  $Res call({
    Object? login = freezed,
    Object? password = freezed,
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
    ));
  }
}

/// @nodoc
abstract class _$AuthenticationRequestCopyWith<$Res>
    implements $AuthenticationRequestCopyWith<$Res> {
  factory _$AuthenticationRequestCopyWith(_AuthenticationRequest value,
          $Res Function(_AuthenticationRequest) then) =
      __$AuthenticationRequestCopyWithImpl<$Res>;
  @override
  $Res call({String login, String password});
}

/// @nodoc
class __$AuthenticationRequestCopyWithImpl<$Res>
    extends _$AuthenticationRequestCopyWithImpl<$Res>
    implements _$AuthenticationRequestCopyWith<$Res> {
  __$AuthenticationRequestCopyWithImpl(_AuthenticationRequest _value,
      $Res Function(_AuthenticationRequest) _then)
      : super(_value, (v) => _then(v as _AuthenticationRequest));

  @override
  _AuthenticationRequest get _value => super._value as _AuthenticationRequest;

  @override
  $Res call({
    Object? login = freezed,
    Object? password = freezed,
  }) {
    return _then(_AuthenticationRequest(
      login == freezed
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AuthenticationRequest implements _AuthenticationRequest {
  _$_AuthenticationRequest(this.login, this.password);

  factory _$_AuthenticationRequest.fromJson(Map<String, dynamic> json) =>
      _$_$_AuthenticationRequestFromJson(json);

  @override
  final String login;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthenticationRequest(login: $login, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticationRequest &&
            (identical(other.login, login) ||
                const DeepCollectionEquality().equals(other.login, login)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(login) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$AuthenticationRequestCopyWith<_AuthenticationRequest> get copyWith =>
      __$AuthenticationRequestCopyWithImpl<_AuthenticationRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AuthenticationRequestToJson(this);
  }
}

abstract class _AuthenticationRequest implements AuthenticationRequest {
  factory _AuthenticationRequest(String login, String password) =
      _$_AuthenticationRequest;

  factory _AuthenticationRequest.fromJson(Map<String, dynamic> json) =
      _$_AuthenticationRequest.fromJson;

  @override
  String get login => throw _privateConstructorUsedError;
  @override
  String get password => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AuthenticationRequestCopyWith<_AuthenticationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
