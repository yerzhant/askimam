// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthEventTearOff {
  const _$AuthEventTearOff();

  _Load load() {
    return const _Load();
  }

  _Logout logout() {
    return const _Logout();
  }

  _Login login(String login, String password) {
    return _Login(
      login,
      password,
    );
  }
}

/// @nodoc
const $AuthEvent = _$AuthEventTearOff();

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() logout,
    required TResult Function(String login, String password) login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? logout,
    TResult Function(String login, String password)? login,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Logout value) logout,
    required TResult Function(_Login value) login,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Logout value)? logout,
    TResult Function(_Login value)? login,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res> implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  final AuthEvent _value;
  // ignore: unused_field
  final $Res Function(AuthEvent) _then;
}

/// @nodoc
abstract class _$LoadCopyWith<$Res> {
  factory _$LoadCopyWith(_Load value, $Res Function(_Load) then) =
      __$LoadCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res>
    implements _$LoadCopyWith<$Res> {
  __$LoadCopyWithImpl(_Load _value, $Res Function(_Load) _then)
      : super(_value, (v) => _then(v as _Load));

  @override
  _Load get _value => super._value as _Load;
}

/// @nodoc
class _$_Load implements _Load {
  const _$_Load();

  @override
  String toString() {
    return 'AuthEvent.load()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() logout,
    required TResult Function(String login, String password) login,
  }) {
    return load();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? logout,
    TResult Function(String login, String password)? login,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Logout value) logout,
    required TResult Function(_Login value) login,
  }) {
    return load(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Logout value)? logout,
    TResult Function(_Login value)? login,
    required TResult orElse(),
  }) {
    if (load != null) {
      return load(this);
    }
    return orElse();
  }
}

abstract class _Load implements AuthEvent {
  const factory _Load() = _$_Load;
}

/// @nodoc
abstract class _$LogoutCopyWith<$Res> {
  factory _$LogoutCopyWith(_Logout value, $Res Function(_Logout) then) =
      __$LogoutCopyWithImpl<$Res>;
}

/// @nodoc
class __$LogoutCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res>
    implements _$LogoutCopyWith<$Res> {
  __$LogoutCopyWithImpl(_Logout _value, $Res Function(_Logout) _then)
      : super(_value, (v) => _then(v as _Logout));

  @override
  _Logout get _value => super._value as _Logout;
}

/// @nodoc
class _$_Logout implements _Logout {
  const _$_Logout();

  @override
  String toString() {
    return 'AuthEvent.logout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Logout);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() logout,
    required TResult Function(String login, String password) login,
  }) {
    return logout();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? logout,
    TResult Function(String login, String password)? login,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Logout value) logout,
    required TResult Function(_Login value) login,
  }) {
    return logout(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Logout value)? logout,
    TResult Function(_Login value)? login,
    required TResult orElse(),
  }) {
    if (logout != null) {
      return logout(this);
    }
    return orElse();
  }
}

abstract class _Logout implements AuthEvent {
  const factory _Logout() = _$_Logout;
}

/// @nodoc
abstract class _$LoginCopyWith<$Res> {
  factory _$LoginCopyWith(_Login value, $Res Function(_Login) then) =
      __$LoginCopyWithImpl<$Res>;
  $Res call({String login, String password});
}

/// @nodoc
class __$LoginCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res>
    implements _$LoginCopyWith<$Res> {
  __$LoginCopyWithImpl(_Login _value, $Res Function(_Login) _then)
      : super(_value, (v) => _then(v as _Login));

  @override
  _Login get _value => super._value as _Login;

  @override
  $Res call({
    Object? login = freezed,
    Object? password = freezed,
  }) {
    return _then(_Login(
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

/// @nodoc
class _$_Login implements _Login {
  const _$_Login(this.login, this.password);

  @override
  final String login;
  @override
  final String password;

  @override
  String toString() {
    return 'AuthEvent.login(login: $login, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Login &&
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
  _$LoginCopyWith<_Login> get copyWith =>
      __$LoginCopyWithImpl<_Login>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() load,
    required TResult Function() logout,
    required TResult Function(String login, String password) login,
  }) {
    return login(this.login, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? load,
    TResult Function()? logout,
    TResult Function(String login, String password)? login,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this.login, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Load value) load,
    required TResult Function(_Logout value) logout,
    required TResult Function(_Login value) login,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Load value)? load,
    TResult Function(_Logout value)? logout,
    TResult Function(_Login value)? login,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class _Login implements AuthEvent {
  const factory _Login(String login, String password) = _$_Login;

  String get login => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$LoginCopyWith<_Login> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  _InProgress inProgress() {
    return const _InProgress();
  }

  _Error error(Rejection rejection) {
    return _Error(
      rejection,
    );
  }

  _Unauthenticated unauthenticated() {
    return const _Unauthenticated();
  }

  _Authenticated authenticated(Authentication authentication) {
    return _Authenticated(
      authentication,
    );
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
    required TResult Function() unauthenticated,
    required TResult Function(Authentication authentication) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    TResult Function()? unauthenticated,
    TResult Function(Authentication authentication)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$InProgressCopyWith<$Res> {
  factory _$InProgressCopyWith(
          _InProgress value, $Res Function(_InProgress) then) =
      __$InProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$InProgressCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$InProgressCopyWith<$Res> {
  __$InProgressCopyWithImpl(
      _InProgress _value, $Res Function(_InProgress) _then)
      : super(_value, (v) => _then(v as _InProgress));

  @override
  _InProgress get _value => super._value as _InProgress;
}

/// @nodoc
class _$_InProgress implements _InProgress {
  const _$_InProgress();

  @override
  String toString() {
    return 'AuthState.inProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
    required TResult Function() unauthenticated,
    required TResult Function(Authentication authentication) authenticated,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    TResult Function()? unauthenticated,
    TResult Function(Authentication authentication)? authenticated,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements AuthState {
  const factory _InProgress() = _$_InProgress;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({Rejection rejection});

  $RejectionCopyWith<$Res> get rejection;
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? rejection = freezed,
  }) {
    return _then(_Error(
      rejection == freezed
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
class _$_Error implements _Error {
  const _$_Error(this.rejection);

  @override
  final Rejection rejection;

  @override
  String toString() {
    return 'AuthState.error(rejection: $rejection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.rejection, rejection) ||
                const DeepCollectionEquality()
                    .equals(other.rejection, rejection)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(rejection);

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
    required TResult Function() unauthenticated,
    required TResult Function(Authentication authentication) authenticated,
  }) {
    return error(rejection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    TResult Function()? unauthenticated,
    TResult Function(Authentication authentication)? authenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(rejection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements AuthState {
  const factory _Error(Rejection rejection) = _$_Error;

  Rejection get rejection => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UnauthenticatedCopyWith<$Res> {
  factory _$UnauthenticatedCopyWith(
          _Unauthenticated value, $Res Function(_Unauthenticated) then) =
      __$UnauthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$UnauthenticatedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$UnauthenticatedCopyWith<$Res> {
  __$UnauthenticatedCopyWithImpl(
      _Unauthenticated _value, $Res Function(_Unauthenticated) _then)
      : super(_value, (v) => _then(v as _Unauthenticated));

  @override
  _Unauthenticated get _value => super._value as _Unauthenticated;
}

/// @nodoc
class _$_Unauthenticated implements _Unauthenticated {
  const _$_Unauthenticated();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Unauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
    required TResult Function() unauthenticated,
    required TResult Function(Authentication authentication) authenticated,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    TResult Function()? unauthenticated,
    TResult Function(Authentication authentication)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _Unauthenticated implements AuthState {
  const factory _Unauthenticated() = _$_Unauthenticated;
}

/// @nodoc
abstract class _$AuthenticatedCopyWith<$Res> {
  factory _$AuthenticatedCopyWith(
          _Authenticated value, $Res Function(_Authenticated) then) =
      __$AuthenticatedCopyWithImpl<$Res>;
  $Res call({Authentication authentication});

  $AuthenticationCopyWith<$Res> get authentication;
}

/// @nodoc
class __$AuthenticatedCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthenticatedCopyWith<$Res> {
  __$AuthenticatedCopyWithImpl(
      _Authenticated _value, $Res Function(_Authenticated) _then)
      : super(_value, (v) => _then(v as _Authenticated));

  @override
  _Authenticated get _value => super._value as _Authenticated;

  @override
  $Res call({
    Object? authentication = freezed,
  }) {
    return _then(_Authenticated(
      authentication == freezed
          ? _value.authentication
          : authentication // ignore: cast_nullable_to_non_nullable
              as Authentication,
    ));
  }

  @override
  $AuthenticationCopyWith<$Res> get authentication {
    return $AuthenticationCopyWith<$Res>(_value.authentication, (value) {
      return _then(_value.copyWith(authentication: value));
    });
  }
}

/// @nodoc
class _$_Authenticated implements _Authenticated {
  const _$_Authenticated(this.authentication);

  @override
  final Authentication authentication;

  @override
  String toString() {
    return 'AuthState.authenticated(authentication: $authentication)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Authenticated &&
            (identical(other.authentication, authentication) ||
                const DeepCollectionEquality()
                    .equals(other.authentication, authentication)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(authentication);

  @JsonKey(ignore: true)
  @override
  _$AuthenticatedCopyWith<_Authenticated> get copyWith =>
      __$AuthenticatedCopyWithImpl<_Authenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
    required TResult Function() unauthenticated,
    required TResult Function(Authentication authentication) authenticated,
  }) {
    return authenticated(authentication);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    TResult Function()? unauthenticated,
    TResult Function(Authentication authentication)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(authentication);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
    required TResult Function(_Unauthenticated value) unauthenticated,
    required TResult Function(_Authenticated value) authenticated,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    TResult Function(_Unauthenticated value)? unauthenticated,
    TResult Function(_Authenticated value)? authenticated,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _Authenticated implements AuthState {
  const factory _Authenticated(Authentication authentication) =
      _$_Authenticated;

  Authentication get authentication => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthenticatedCopyWith<_Authenticated> get copyWith =>
      throw _privateConstructorUsedError;
}
