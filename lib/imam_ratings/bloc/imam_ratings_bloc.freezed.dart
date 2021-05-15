// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'imam_ratings_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ImamRatingsEventTearOff {
  const _$ImamRatingsEventTearOff();

  _Reload reload() {
    return const _Reload();
  }
}

/// @nodoc
const $ImamRatingsEvent = _$ImamRatingsEventTearOff();

/// @nodoc
mixin _$ImamRatingsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reload,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Reload value) reload,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Reload value)? reload,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImamRatingsEventCopyWith<$Res> {
  factory $ImamRatingsEventCopyWith(
          ImamRatingsEvent value, $Res Function(ImamRatingsEvent) then) =
      _$ImamRatingsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ImamRatingsEventCopyWithImpl<$Res>
    implements $ImamRatingsEventCopyWith<$Res> {
  _$ImamRatingsEventCopyWithImpl(this._value, this._then);

  final ImamRatingsEvent _value;
  // ignore: unused_field
  final $Res Function(ImamRatingsEvent) _then;
}

/// @nodoc
abstract class _$ReloadCopyWith<$Res> {
  factory _$ReloadCopyWith(_Reload value, $Res Function(_Reload) then) =
      __$ReloadCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReloadCopyWithImpl<$Res> extends _$ImamRatingsEventCopyWithImpl<$Res>
    implements _$ReloadCopyWith<$Res> {
  __$ReloadCopyWithImpl(_Reload _value, $Res Function(_Reload) _then)
      : super(_value, (v) => _then(v as _Reload));

  @override
  _Reload get _value => super._value as _Reload;
}

/// @nodoc
class _$_Reload implements _Reload {
  const _$_Reload();

  @override
  String toString() {
    return 'ImamRatingsEvent.reload()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Reload);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() reload,
  }) {
    return reload();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? reload,
    required TResult orElse(),
  }) {
    if (reload != null) {
      return reload();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Reload value) reload,
  }) {
    return reload(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Reload value)? reload,
    required TResult orElse(),
  }) {
    if (reload != null) {
      return reload(this);
    }
    return orElse();
  }
}

abstract class _Reload implements ImamRatingsEvent {
  const factory _Reload() = _$_Reload;
}

/// @nodoc
class _$ImamRatingsStateTearOff {
  const _$ImamRatingsStateTearOff();

  _State call(ImamRatingsWithDescription ratings) {
    return _State(
      ratings,
    );
  }

  _InProgress inProgress() {
    return const _InProgress();
  }

  _Error error(Rejection rejection) {
    return _Error(
      rejection,
    );
  }
}

/// @nodoc
const $ImamRatingsState = _$ImamRatingsStateTearOff();

/// @nodoc
mixin _$ImamRatingsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImamRatingsStateCopyWith<$Res> {
  factory $ImamRatingsStateCopyWith(
          ImamRatingsState value, $Res Function(ImamRatingsState) then) =
      _$ImamRatingsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ImamRatingsStateCopyWithImpl<$Res>
    implements $ImamRatingsStateCopyWith<$Res> {
  _$ImamRatingsStateCopyWithImpl(this._value, this._then);

  final ImamRatingsState _value;
  // ignore: unused_field
  final $Res Function(ImamRatingsState) _then;
}

/// @nodoc
abstract class _$StateCopyWith<$Res> {
  factory _$StateCopyWith(_State value, $Res Function(_State) then) =
      __$StateCopyWithImpl<$Res>;
  $Res call({ImamRatingsWithDescription ratings});

  $ImamRatingsWithDescriptionCopyWith<$Res> get ratings;
}

/// @nodoc
class __$StateCopyWithImpl<$Res> extends _$ImamRatingsStateCopyWithImpl<$Res>
    implements _$StateCopyWith<$Res> {
  __$StateCopyWithImpl(_State _value, $Res Function(_State) _then)
      : super(_value, (v) => _then(v as _State));

  @override
  _State get _value => super._value as _State;

  @override
  $Res call({
    Object? ratings = freezed,
  }) {
    return _then(_State(
      ratings == freezed
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as ImamRatingsWithDescription,
    ));
  }

  @override
  $ImamRatingsWithDescriptionCopyWith<$Res> get ratings {
    return $ImamRatingsWithDescriptionCopyWith<$Res>(_value.ratings, (value) {
      return _then(_value.copyWith(ratings: value));
    });
  }
}

/// @nodoc
class _$_State implements _State {
  const _$_State(this.ratings);

  @override
  final ImamRatingsWithDescription ratings;

  @override
  String toString() {
    return 'ImamRatingsState(ratings: $ratings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _State &&
            (identical(other.ratings, ratings) ||
                const DeepCollectionEquality().equals(other.ratings, ratings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(ratings);

  @JsonKey(ignore: true)
  @override
  _$StateCopyWith<_State> get copyWith =>
      __$StateCopyWithImpl<_State>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return $default(ratings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(ratings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _State implements ImamRatingsState {
  const factory _State(ImamRatingsWithDescription ratings) = _$_State;

  ImamRatingsWithDescription get ratings => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$StateCopyWith<_State> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$InProgressCopyWith<$Res> {
  factory _$InProgressCopyWith(
          _InProgress value, $Res Function(_InProgress) then) =
      __$InProgressCopyWithImpl<$Res>;
}

/// @nodoc
class __$InProgressCopyWithImpl<$Res>
    extends _$ImamRatingsStateCopyWithImpl<$Res>
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
    return 'ImamRatingsState.inProgress()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _InProgress);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) {
    return inProgress(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(this);
    }
    return orElse();
  }
}

abstract class _InProgress implements ImamRatingsState {
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
class __$ErrorCopyWithImpl<$Res> extends _$ImamRatingsStateCopyWithImpl<$Res>
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
    return 'ImamRatingsState.error(rejection: $rejection)';
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
  TResult when<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return error(rejection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(ImamRatingsWithDescription ratings)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(rejection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_State value) $default, {
    required TResult Function(_InProgress value) inProgress,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_State value)? $default, {
    TResult Function(_InProgress value)? inProgress,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements ImamRatingsState {
  const factory _Error(Rejection rejection) = _$_Error;

  Rejection get rejection => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}
