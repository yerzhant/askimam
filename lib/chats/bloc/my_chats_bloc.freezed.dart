// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'my_chats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MyChatsEventTearOff {
  const _$MyChatsEventTearOff();

  _Show show() {
    return const _Show();
  }

  _Reload reload() {
    return const _Reload();
  }

  _Delete delete(Chat chat) {
    return _Delete(
      chat,
    );
  }

  _LoadNextPage loadNextPage() {
    return const _LoadNextPage();
  }

  _UpdateFavorites updateFavorites(List<Favorite> favorites) {
    return _UpdateFavorites(
      favorites,
    );
  }
}

/// @nodoc
const $MyChatsEvent = _$MyChatsEventTearOff();

/// @nodoc
mixin _$MyChatsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() reload,
    required TResult Function(Chat chat) delete,
    required TResult Function() loadNextPage,
    required TResult Function(List<Favorite> favorites) updateFavorites,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? reload,
    TResult Function(Chat chat)? delete,
    TResult Function()? loadNextPage,
    TResult Function(List<Favorite> favorites)? updateFavorites,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Reload value) reload,
    required TResult Function(_Delete value) delete,
    required TResult Function(_LoadNextPage value) loadNextPage,
    required TResult Function(_UpdateFavorites value) updateFavorites,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Reload value)? reload,
    TResult Function(_Delete value)? delete,
    TResult Function(_LoadNextPage value)? loadNextPage,
    TResult Function(_UpdateFavorites value)? updateFavorites,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyChatsEventCopyWith<$Res> {
  factory $MyChatsEventCopyWith(
          MyChatsEvent value, $Res Function(MyChatsEvent) then) =
      _$MyChatsEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$MyChatsEventCopyWithImpl<$Res> implements $MyChatsEventCopyWith<$Res> {
  _$MyChatsEventCopyWithImpl(this._value, this._then);

  final MyChatsEvent _value;
  // ignore: unused_field
  final $Res Function(MyChatsEvent) _then;
}

/// @nodoc
abstract class _$ShowCopyWith<$Res> {
  factory _$ShowCopyWith(_Show value, $Res Function(_Show) then) =
      __$ShowCopyWithImpl<$Res>;
}

/// @nodoc
class __$ShowCopyWithImpl<$Res> extends _$MyChatsEventCopyWithImpl<$Res>
    implements _$ShowCopyWith<$Res> {
  __$ShowCopyWithImpl(_Show _value, $Res Function(_Show) _then)
      : super(_value, (v) => _then(v as _Show));

  @override
  _Show get _value => super._value as _Show;
}

/// @nodoc
class _$_Show implements _Show {
  const _$_Show();

  @override
  String toString() {
    return 'MyChatsEvent.show()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Show);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() reload,
    required TResult Function(Chat chat) delete,
    required TResult Function() loadNextPage,
    required TResult Function(List<Favorite> favorites) updateFavorites,
  }) {
    return show();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? reload,
    TResult Function(Chat chat)? delete,
    TResult Function()? loadNextPage,
    TResult Function(List<Favorite> favorites)? updateFavorites,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Reload value) reload,
    required TResult Function(_Delete value) delete,
    required TResult Function(_LoadNextPage value) loadNextPage,
    required TResult Function(_UpdateFavorites value) updateFavorites,
  }) {
    return show(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Reload value)? reload,
    TResult Function(_Delete value)? delete,
    TResult Function(_LoadNextPage value)? loadNextPage,
    TResult Function(_UpdateFavorites value)? updateFavorites,
    required TResult orElse(),
  }) {
    if (show != null) {
      return show(this);
    }
    return orElse();
  }
}

abstract class _Show implements MyChatsEvent {
  const factory _Show() = _$_Show;
}

/// @nodoc
abstract class _$ReloadCopyWith<$Res> {
  factory _$ReloadCopyWith(_Reload value, $Res Function(_Reload) then) =
      __$ReloadCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReloadCopyWithImpl<$Res> extends _$MyChatsEventCopyWithImpl<$Res>
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
    return 'MyChatsEvent.reload()';
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
    required TResult Function() show,
    required TResult Function() reload,
    required TResult Function(Chat chat) delete,
    required TResult Function() loadNextPage,
    required TResult Function(List<Favorite> favorites) updateFavorites,
  }) {
    return reload();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? reload,
    TResult Function(Chat chat)? delete,
    TResult Function()? loadNextPage,
    TResult Function(List<Favorite> favorites)? updateFavorites,
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
    required TResult Function(_Show value) show,
    required TResult Function(_Reload value) reload,
    required TResult Function(_Delete value) delete,
    required TResult Function(_LoadNextPage value) loadNextPage,
    required TResult Function(_UpdateFavorites value) updateFavorites,
  }) {
    return reload(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Reload value)? reload,
    TResult Function(_Delete value)? delete,
    TResult Function(_LoadNextPage value)? loadNextPage,
    TResult Function(_UpdateFavorites value)? updateFavorites,
    required TResult orElse(),
  }) {
    if (reload != null) {
      return reload(this);
    }
    return orElse();
  }
}

abstract class _Reload implements MyChatsEvent {
  const factory _Reload() = _$_Reload;
}

/// @nodoc
abstract class _$DeleteCopyWith<$Res> {
  factory _$DeleteCopyWith(_Delete value, $Res Function(_Delete) then) =
      __$DeleteCopyWithImpl<$Res>;
  $Res call({Chat chat});

  $ChatCopyWith<$Res> get chat;
}

/// @nodoc
class __$DeleteCopyWithImpl<$Res> extends _$MyChatsEventCopyWithImpl<$Res>
    implements _$DeleteCopyWith<$Res> {
  __$DeleteCopyWithImpl(_Delete _value, $Res Function(_Delete) _then)
      : super(_value, (v) => _then(v as _Delete));

  @override
  _Delete get _value => super._value as _Delete;

  @override
  $Res call({
    Object? chat = freezed,
  }) {
    return _then(_Delete(
      chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
    ));
  }

  @override
  $ChatCopyWith<$Res> get chat {
    return $ChatCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value));
    });
  }
}

/// @nodoc
class _$_Delete implements _Delete {
  const _$_Delete(this.chat);

  @override
  final Chat chat;

  @override
  String toString() {
    return 'MyChatsEvent.delete(chat: $chat)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Delete &&
            (identical(other.chat, chat) ||
                const DeepCollectionEquality().equals(other.chat, chat)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chat);

  @JsonKey(ignore: true)
  @override
  _$DeleteCopyWith<_Delete> get copyWith =>
      __$DeleteCopyWithImpl<_Delete>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() reload,
    required TResult Function(Chat chat) delete,
    required TResult Function() loadNextPage,
    required TResult Function(List<Favorite> favorites) updateFavorites,
  }) {
    return delete(chat);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? reload,
    TResult Function(Chat chat)? delete,
    TResult Function()? loadNextPage,
    TResult Function(List<Favorite> favorites)? updateFavorites,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(chat);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Reload value) reload,
    required TResult Function(_Delete value) delete,
    required TResult Function(_LoadNextPage value) loadNextPage,
    required TResult Function(_UpdateFavorites value) updateFavorites,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Reload value)? reload,
    TResult Function(_Delete value)? delete,
    TResult Function(_LoadNextPage value)? loadNextPage,
    TResult Function(_UpdateFavorites value)? updateFavorites,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class _Delete implements MyChatsEvent {
  const factory _Delete(Chat chat) = _$_Delete;

  Chat get chat => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DeleteCopyWith<_Delete> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoadNextPageCopyWith<$Res> {
  factory _$LoadNextPageCopyWith(
          _LoadNextPage value, $Res Function(_LoadNextPage) then) =
      __$LoadNextPageCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadNextPageCopyWithImpl<$Res> extends _$MyChatsEventCopyWithImpl<$Res>
    implements _$LoadNextPageCopyWith<$Res> {
  __$LoadNextPageCopyWithImpl(
      _LoadNextPage _value, $Res Function(_LoadNextPage) _then)
      : super(_value, (v) => _then(v as _LoadNextPage));

  @override
  _LoadNextPage get _value => super._value as _LoadNextPage;
}

/// @nodoc
class _$_LoadNextPage implements _LoadNextPage {
  const _$_LoadNextPage();

  @override
  String toString() {
    return 'MyChatsEvent.loadNextPage()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LoadNextPage);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() reload,
    required TResult Function(Chat chat) delete,
    required TResult Function() loadNextPage,
    required TResult Function(List<Favorite> favorites) updateFavorites,
  }) {
    return loadNextPage();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? reload,
    TResult Function(Chat chat)? delete,
    TResult Function()? loadNextPage,
    TResult Function(List<Favorite> favorites)? updateFavorites,
    required TResult orElse(),
  }) {
    if (loadNextPage != null) {
      return loadNextPage();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Reload value) reload,
    required TResult Function(_Delete value) delete,
    required TResult Function(_LoadNextPage value) loadNextPage,
    required TResult Function(_UpdateFavorites value) updateFavorites,
  }) {
    return loadNextPage(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Reload value)? reload,
    TResult Function(_Delete value)? delete,
    TResult Function(_LoadNextPage value)? loadNextPage,
    TResult Function(_UpdateFavorites value)? updateFavorites,
    required TResult orElse(),
  }) {
    if (loadNextPage != null) {
      return loadNextPage(this);
    }
    return orElse();
  }
}

abstract class _LoadNextPage implements MyChatsEvent {
  const factory _LoadNextPage() = _$_LoadNextPage;
}

/// @nodoc
abstract class _$UpdateFavoritesCopyWith<$Res> {
  factory _$UpdateFavoritesCopyWith(
          _UpdateFavorites value, $Res Function(_UpdateFavorites) then) =
      __$UpdateFavoritesCopyWithImpl<$Res>;
  $Res call({List<Favorite> favorites});
}

/// @nodoc
class __$UpdateFavoritesCopyWithImpl<$Res>
    extends _$MyChatsEventCopyWithImpl<$Res>
    implements _$UpdateFavoritesCopyWith<$Res> {
  __$UpdateFavoritesCopyWithImpl(
      _UpdateFavorites _value, $Res Function(_UpdateFavorites) _then)
      : super(_value, (v) => _then(v as _UpdateFavorites));

  @override
  _UpdateFavorites get _value => super._value as _UpdateFavorites;

  @override
  $Res call({
    Object? favorites = freezed,
  }) {
    return _then(_UpdateFavorites(
      favorites == freezed
          ? _value.favorites
          : favorites // ignore: cast_nullable_to_non_nullable
              as List<Favorite>,
    ));
  }
}

/// @nodoc
class _$_UpdateFavorites implements _UpdateFavorites {
  const _$_UpdateFavorites(this.favorites);

  @override
  final List<Favorite> favorites;

  @override
  String toString() {
    return 'MyChatsEvent.updateFavorites(favorites: $favorites)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateFavorites &&
            (identical(other.favorites, favorites) ||
                const DeepCollectionEquality()
                    .equals(other.favorites, favorites)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(favorites);

  @JsonKey(ignore: true)
  @override
  _$UpdateFavoritesCopyWith<_UpdateFavorites> get copyWith =>
      __$UpdateFavoritesCopyWithImpl<_UpdateFavorites>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() show,
    required TResult Function() reload,
    required TResult Function(Chat chat) delete,
    required TResult Function() loadNextPage,
    required TResult Function(List<Favorite> favorites) updateFavorites,
  }) {
    return updateFavorites(favorites);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? show,
    TResult Function()? reload,
    TResult Function(Chat chat)? delete,
    TResult Function()? loadNextPage,
    TResult Function(List<Favorite> favorites)? updateFavorites,
    required TResult orElse(),
  }) {
    if (updateFavorites != null) {
      return updateFavorites(favorites);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Show value) show,
    required TResult Function(_Reload value) reload,
    required TResult Function(_Delete value) delete,
    required TResult Function(_LoadNextPage value) loadNextPage,
    required TResult Function(_UpdateFavorites value) updateFavorites,
  }) {
    return updateFavorites(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Show value)? show,
    TResult Function(_Reload value)? reload,
    TResult Function(_Delete value)? delete,
    TResult Function(_LoadNextPage value)? loadNextPage,
    TResult Function(_UpdateFavorites value)? updateFavorites,
    required TResult orElse(),
  }) {
    if (updateFavorites != null) {
      return updateFavorites(this);
    }
    return orElse();
  }
}

abstract class _UpdateFavorites implements MyChatsEvent {
  const factory _UpdateFavorites(List<Favorite> favorites) = _$_UpdateFavorites;

  List<Favorite> get favorites => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$UpdateFavoritesCopyWith<_UpdateFavorites> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$MyChatsStateTearOff {
  const _$MyChatsStateTearOff();

  _State call(List<Chat> chats) {
    return _State(
      chats,
    );
  }

  _InProgress inProgress(List<Chat> chats) {
    return _InProgress(
      chats,
    );
  }

  _Error error(Rejection rejection) {
    return _Error(
      rejection,
    );
  }
}

/// @nodoc
const $MyChatsState = _$MyChatsStateTearOff();

/// @nodoc
mixin _$MyChatsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Chat> chats) $default, {
    required TResult Function(List<Chat> chats) inProgress,
    required TResult Function(Rejection rejection) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
    TResult Function(List<Chat> chats)? inProgress,
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
abstract class $MyChatsStateCopyWith<$Res> {
  factory $MyChatsStateCopyWith(
          MyChatsState value, $Res Function(MyChatsState) then) =
      _$MyChatsStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$MyChatsStateCopyWithImpl<$Res> implements $MyChatsStateCopyWith<$Res> {
  _$MyChatsStateCopyWithImpl(this._value, this._then);

  final MyChatsState _value;
  // ignore: unused_field
  final $Res Function(MyChatsState) _then;
}

/// @nodoc
abstract class _$StateCopyWith<$Res> {
  factory _$StateCopyWith(_State value, $Res Function(_State) then) =
      __$StateCopyWithImpl<$Res>;
  $Res call({List<Chat> chats});
}

/// @nodoc
class __$StateCopyWithImpl<$Res> extends _$MyChatsStateCopyWithImpl<$Res>
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
    return 'MyChatsState(chats: $chats)';
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
    required TResult Function(List<Chat> chats) inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return $default(chats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
    TResult Function(List<Chat> chats)? inProgress,
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

abstract class _State implements MyChatsState {
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
  $Res call({List<Chat> chats});
}

/// @nodoc
class __$InProgressCopyWithImpl<$Res> extends _$MyChatsStateCopyWithImpl<$Res>
    implements _$InProgressCopyWith<$Res> {
  __$InProgressCopyWithImpl(
      _InProgress _value, $Res Function(_InProgress) _then)
      : super(_value, (v) => _then(v as _InProgress));

  @override
  _InProgress get _value => super._value as _InProgress;

  @override
  $Res call({
    Object? chats = freezed,
  }) {
    return _then(_InProgress(
      chats == freezed
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<Chat>,
    ));
  }
}

/// @nodoc
class _$_InProgress implements _InProgress {
  const _$_InProgress(this.chats);

  @override
  final List<Chat> chats;

  @override
  String toString() {
    return 'MyChatsState.inProgress(chats: $chats)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _InProgress &&
            (identical(other.chats, chats) ||
                const DeepCollectionEquality().equals(other.chats, chats)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(chats);

  @JsonKey(ignore: true)
  @override
  _$InProgressCopyWith<_InProgress> get copyWith =>
      __$InProgressCopyWithImpl<_InProgress>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(List<Chat> chats) $default, {
    required TResult Function(List<Chat> chats) inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return inProgress(chats);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
    TResult Function(List<Chat> chats)? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if (inProgress != null) {
      return inProgress(chats);
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

abstract class _InProgress implements MyChatsState {
  const factory _InProgress(List<Chat> chats) = _$_InProgress;

  List<Chat> get chats => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$InProgressCopyWith<_InProgress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  $Res call({Rejection rejection});

  $RejectionCopyWith<$Res> get rejection;
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$MyChatsStateCopyWithImpl<$Res>
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
    return 'MyChatsState.error(rejection: $rejection)';
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
    required TResult Function(List<Chat> chats) inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return error(rejection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(List<Chat> chats)? $default, {
    TResult Function(List<Chat> chats)? inProgress,
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

abstract class _Error implements MyChatsState {
  const factory _Error(Rejection rejection) = _$_Error;

  Rejection get rejection => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}
