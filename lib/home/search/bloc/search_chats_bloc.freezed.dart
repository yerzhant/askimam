// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'search_chats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SearchChatsEventTearOff {
  const _$SearchChatsEventTearOff();

  _Find find(String phrase) {
    return _Find(
      phrase,
    );
  }
}

/// @nodoc
const $SearchChatsEvent = _$SearchChatsEventTearOff();

/// @nodoc
mixin _$SearchChatsEvent {
  String get phrase => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phrase) find,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phrase)? find,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Find value) find,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Find value)? find,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchChatsEventCopyWith<SearchChatsEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchChatsEventCopyWith<$Res> {
  factory $SearchChatsEventCopyWith(
          SearchChatsEvent value, $Res Function(SearchChatsEvent) then) =
      _$SearchChatsEventCopyWithImpl<$Res>;
  $Res call({String phrase});
}

/// @nodoc
class _$SearchChatsEventCopyWithImpl<$Res>
    implements $SearchChatsEventCopyWith<$Res> {
  _$SearchChatsEventCopyWithImpl(this._value, this._then);

  final SearchChatsEvent _value;
  // ignore: unused_field
  final $Res Function(SearchChatsEvent) _then;

  @override
  $Res call({
    Object? phrase = freezed,
  }) {
    return _then(_value.copyWith(
      phrase: phrase == freezed
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$FindCopyWith<$Res> implements $SearchChatsEventCopyWith<$Res> {
  factory _$FindCopyWith(_Find value, $Res Function(_Find) then) =
      __$FindCopyWithImpl<$Res>;
  @override
  $Res call({String phrase});
}

/// @nodoc
class __$FindCopyWithImpl<$Res> extends _$SearchChatsEventCopyWithImpl<$Res>
    implements _$FindCopyWith<$Res> {
  __$FindCopyWithImpl(_Find _value, $Res Function(_Find) _then)
      : super(_value, (v) => _then(v as _Find));

  @override
  _Find get _value => super._value as _Find;

  @override
  $Res call({
    Object? phrase = freezed,
  }) {
    return _then(_Find(
      phrase == freezed
          ? _value.phrase
          : phrase // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_Find implements _Find {
  const _$_Find(this.phrase);

  @override
  final String phrase;

  @override
  String toString() {
    return 'SearchChatsEvent.find(phrase: $phrase)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Find &&
            (identical(other.phrase, phrase) ||
                const DeepCollectionEquality().equals(other.phrase, phrase)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(phrase);

  @JsonKey(ignore: true)
  @override
  _$FindCopyWith<_Find> get copyWith =>
      __$FindCopyWithImpl<_Find>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String phrase) find,
  }) {
    return find(phrase);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String phrase)? find,
    required TResult orElse(),
  }) {
    if (find != null) {
      return find(phrase);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Find value) find,
  }) {
    return find(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Find value)? find,
    required TResult orElse(),
  }) {
    if (find != null) {
      return find(this);
    }
    return orElse();
  }
}

abstract class _Find implements SearchChatsEvent {
  const factory _Find(String phrase) = _$_Find;

  @override
  String get phrase => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$FindCopyWith<_Find> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
class _$SearchChatsStateTearOff {
  const _$SearchChatsStateTearOff();

  _State call(List<Chat> chats) {
    return _State(
      chats,
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
const $SearchChatsState = _$SearchChatsStateTearOff();

/// @nodoc
mixin _$SearchChatsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Chat> chats) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
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
abstract class $SearchChatsStateCopyWith<$Res> {
  factory $SearchChatsStateCopyWith(
          SearchChatsState value, $Res Function(SearchChatsState) then) =
      _$SearchChatsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SearchChatsStateCopyWithImpl<$Res>
    implements $SearchChatsStateCopyWith<$Res> {
  _$SearchChatsStateCopyWithImpl(this._value, this._then);

  final SearchChatsState _value;
  // ignore: unused_field
  final $Res Function(SearchChatsState) _then;
}

/// @nodoc
abstract class _$StateCopyWith<$Res> {
  factory _$StateCopyWith(_State value, $Res Function(_State) then) =
      __$StateCopyWithImpl<$Res>;
  $Res call({List<Chat> chats});
}

/// @nodoc
class __$StateCopyWithImpl<$Res> extends _$SearchChatsStateCopyWithImpl<$Res>
    implements _$StateCopyWith<$Res> {
  __$StateCopyWithImpl(_State _value, $Res Function(_State) _then)
      : super(_value, (v) => _then(v as _State));

  @override
  _State get _value => super._value as _State;

  @override
  $Res call({
    Object? chats = freezed,
  }) {
    return _then(_State(
      chats == freezed
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
    ));
  }
}

/// @nodoc
class _$_State implements _State {
  const _$_State(this.chats);

  @override
  final List<Chat> chats;

  @override
  String toString() {
    return 'SearchChatsState(chats: $chats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _State &&
            (identical(other.chats, chats) ||
                const DeepCollectionEquality().equals(other.chats, chats)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chats);

  @JsonKey(ignore: true)
  @override
  _$StateCopyWith<_State> get copyWith =>
      __$StateCopyWithImpl<_State>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Chat> chats) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return $default(chats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(chats);
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

abstract class _State implements SearchChatsState {
  const factory _State(List<Chat> chats) = _$_State;

  List<Chat> get chats => throw _privateConstructorUsedError;
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
    extends _$SearchChatsStateCopyWithImpl<$Res>
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
    return 'SearchChatsState.inProgress()';
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
    TResult Function(List<Chat> chats) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
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

abstract class _InProgress implements SearchChatsState {
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
class __$ErrorCopyWithImpl<$Res> extends _$SearchChatsStateCopyWithImpl<$Res>
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
    return 'SearchChatsState.error(rejection: $rejection)';
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
    TResult Function(List<Chat> chats) $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return error(rejection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
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

abstract class _Error implements SearchChatsState {
  const factory _Error(Rejection rejection) = _$_Error;

  Rejection get rejection => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}
