// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ChatEventTearOff {
  const _$ChatEventTearOff();

  _Refresh refresh(int id) {
    return _Refresh(
      id,
    );
  }

  _ReturnToUnaswered returnToUnaswered() {
    return const _ReturnToUnaswered();
  }

  _UpdateSubject updateSubject(String subject) {
    return _UpdateSubject(
      subject,
    );
  }

  _AddText addText(String text) {
    return _AddText(
      text,
    );
  }

  _DeleteMessage deleteMessage(int id) {
    return _DeleteMessage(
      id,
    );
  }

  _UpdateTextMessage updateTextMessage(int id, String text) {
    return _UpdateTextMessage(
      id,
      text,
    );
  }
}

/// @nodoc
const $ChatEvent = _$ChatEventTearOff();

/// @nodoc
mixin _$ChatEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEventCopyWith<$Res> {
  factory $ChatEventCopyWith(ChatEvent value, $Res Function(ChatEvent) then) =
      _$ChatEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatEventCopyWithImpl<$Res> implements $ChatEventCopyWith<$Res> {
  _$ChatEventCopyWithImpl(this._value, this._then);

  final ChatEvent _value;
  // ignore: unused_field
  final $Res Function(ChatEvent) _then;
}

/// @nodoc
abstract class _$RefreshCopyWith<$Res> {
  factory _$RefreshCopyWith(_Refresh value, $Res Function(_Refresh) then) =
      __$RefreshCopyWithImpl<$Res>;
  $Res call({int id});
}

/// @nodoc
class __$RefreshCopyWithImpl<$Res> extends _$ChatEventCopyWithImpl<$Res>
    implements _$RefreshCopyWith<$Res> {
  __$RefreshCopyWithImpl(_Refresh _value, $Res Function(_Refresh) _then)
      : super(_value, (v) => _then(v as _Refresh));

  @override
  _Refresh get _value => super._value as _Refresh;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_Refresh(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
class _$_Refresh implements _Refresh {
  const _$_Refresh(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'ChatEvent.refresh(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Refresh &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$RefreshCopyWith<_Refresh> get copyWith =>
      __$RefreshCopyWithImpl<_Refresh>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) {
    return refresh(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) {
    return refresh(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (refresh != null) {
      return refresh(this);
    }
    return orElse();
  }
}

abstract class _Refresh implements ChatEvent {
  const factory _Refresh(int id) = _$_Refresh;

  int get id => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$RefreshCopyWith<_Refresh> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ReturnToUnasweredCopyWith<$Res> {
  factory _$ReturnToUnasweredCopyWith(
          _ReturnToUnaswered value, $Res Function(_ReturnToUnaswered) then) =
      __$ReturnToUnasweredCopyWithImpl<$Res>;
}

/// @nodoc
class __$ReturnToUnasweredCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res>
    implements _$ReturnToUnasweredCopyWith<$Res> {
  __$ReturnToUnasweredCopyWithImpl(
      _ReturnToUnaswered _value, $Res Function(_ReturnToUnaswered) _then)
      : super(_value, (v) => _then(v as _ReturnToUnaswered));

  @override
  _ReturnToUnaswered get _value => super._value as _ReturnToUnaswered;
}

/// @nodoc
class _$_ReturnToUnaswered implements _ReturnToUnaswered {
  const _$_ReturnToUnaswered();

  @override
  String toString() {
    return 'ChatEvent.returnToUnaswered()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _ReturnToUnaswered);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) {
    return returnToUnaswered();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (returnToUnaswered != null) {
      return returnToUnaswered();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) {
    return returnToUnaswered(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (returnToUnaswered != null) {
      return returnToUnaswered(this);
    }
    return orElse();
  }
}

abstract class _ReturnToUnaswered implements ChatEvent {
  const factory _ReturnToUnaswered() = _$_ReturnToUnaswered;
}

/// @nodoc
abstract class _$UpdateSubjectCopyWith<$Res> {
  factory _$UpdateSubjectCopyWith(
          _UpdateSubject value, $Res Function(_UpdateSubject) then) =
      __$UpdateSubjectCopyWithImpl<$Res>;
  $Res call({String subject});
}

/// @nodoc
class __$UpdateSubjectCopyWithImpl<$Res> extends _$ChatEventCopyWithImpl<$Res>
    implements _$UpdateSubjectCopyWith<$Res> {
  __$UpdateSubjectCopyWithImpl(
      _UpdateSubject _value, $Res Function(_UpdateSubject) _then)
      : super(_value, (v) => _then(v as _UpdateSubject));

  @override
  _UpdateSubject get _value => super._value as _UpdateSubject;

  @override
  $Res call({
    Object? subject = freezed,
  }) {
    return _then(_UpdateSubject(
      subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_UpdateSubject implements _UpdateSubject {
  const _$_UpdateSubject(this.subject);

  @override
  final String subject;

  @override
  String toString() {
    return 'ChatEvent.updateSubject(subject: $subject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateSubject &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality().equals(other.subject, subject)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(subject);

  @JsonKey(ignore: true)
  @override
  _$UpdateSubjectCopyWith<_UpdateSubject> get copyWith =>
      __$UpdateSubjectCopyWithImpl<_UpdateSubject>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) {
    return updateSubject(subject);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (updateSubject != null) {
      return updateSubject(subject);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) {
    return updateSubject(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (updateSubject != null) {
      return updateSubject(this);
    }
    return orElse();
  }
}

abstract class _UpdateSubject implements ChatEvent {
  const factory _UpdateSubject(String subject) = _$_UpdateSubject;

  String get subject => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$UpdateSubjectCopyWith<_UpdateSubject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AddTextCopyWith<$Res> {
  factory _$AddTextCopyWith(_AddText value, $Res Function(_AddText) then) =
      __$AddTextCopyWithImpl<$Res>;
  $Res call({String text});
}

/// @nodoc
class __$AddTextCopyWithImpl<$Res> extends _$ChatEventCopyWithImpl<$Res>
    implements _$AddTextCopyWith<$Res> {
  __$AddTextCopyWithImpl(_AddText _value, $Res Function(_AddText) _then)
      : super(_value, (v) => _then(v as _AddText));

  @override
  _AddText get _value => super._value as _AddText;

  @override
  $Res call({
    Object? text = freezed,
  }) {
    return _then(_AddText(
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_AddText implements _AddText {
  const _$_AddText(this.text);

  @override
  final String text;

  @override
  String toString() {
    return 'ChatEvent.addText(text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddText &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(text);

  @JsonKey(ignore: true)
  @override
  _$AddTextCopyWith<_AddText> get copyWith =>
      __$AddTextCopyWithImpl<_AddText>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) {
    return addText(text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (addText != null) {
      return addText(text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) {
    return addText(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (addText != null) {
      return addText(this);
    }
    return orElse();
  }
}

abstract class _AddText implements ChatEvent {
  const factory _AddText(String text) = _$_AddText;

  String get text => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AddTextCopyWith<_AddText> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DeleteMessageCopyWith<$Res> {
  factory _$DeleteMessageCopyWith(
          _DeleteMessage value, $Res Function(_DeleteMessage) then) =
      __$DeleteMessageCopyWithImpl<$Res>;
  $Res call({int id});
}

/// @nodoc
class __$DeleteMessageCopyWithImpl<$Res> extends _$ChatEventCopyWithImpl<$Res>
    implements _$DeleteMessageCopyWith<$Res> {
  __$DeleteMessageCopyWithImpl(
      _DeleteMessage _value, $Res Function(_DeleteMessage) _then)
      : super(_value, (v) => _then(v as _DeleteMessage));

  @override
  _DeleteMessage get _value => super._value as _DeleteMessage;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_DeleteMessage(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
class _$_DeleteMessage implements _DeleteMessage {
  const _$_DeleteMessage(this.id);

  @override
  final int id;

  @override
  String toString() {
    return 'ChatEvent.deleteMessage(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _DeleteMessage &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$DeleteMessageCopyWith<_DeleteMessage> get copyWith =>
      __$DeleteMessageCopyWithImpl<_DeleteMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) {
    return deleteMessage(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) {
    return deleteMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (deleteMessage != null) {
      return deleteMessage(this);
    }
    return orElse();
  }
}

abstract class _DeleteMessage implements ChatEvent {
  const factory _DeleteMessage(int id) = _$_DeleteMessage;

  int get id => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$DeleteMessageCopyWith<_DeleteMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$UpdateTextMessageCopyWith<$Res> {
  factory _$UpdateTextMessageCopyWith(
          _UpdateTextMessage value, $Res Function(_UpdateTextMessage) then) =
      __$UpdateTextMessageCopyWithImpl<$Res>;
  $Res call({int id, String text});
}

/// @nodoc
class __$UpdateTextMessageCopyWithImpl<$Res>
    extends _$ChatEventCopyWithImpl<$Res>
    implements _$UpdateTextMessageCopyWith<$Res> {
  __$UpdateTextMessageCopyWithImpl(
      _UpdateTextMessage _value, $Res Function(_UpdateTextMessage) _then)
      : super(_value, (v) => _then(v as _UpdateTextMessage));

  @override
  _UpdateTextMessage get _value => super._value as _UpdateTextMessage;

  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
  }) {
    return _then(_UpdateTextMessage(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$_UpdateTextMessage implements _UpdateTextMessage {
  const _$_UpdateTextMessage(this.id, this.text);

  @override
  final int id;
  @override
  final String text;

  @override
  String toString() {
    return 'ChatEvent.updateTextMessage(id: $id, text: $text)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateTextMessage &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(text);

  @JsonKey(ignore: true)
  @override
  _$UpdateTextMessageCopyWith<_UpdateTextMessage> get copyWith =>
      __$UpdateTextMessageCopyWithImpl<_UpdateTextMessage>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) refresh,
    required TResult Function() returnToUnaswered,
    required TResult Function(String subject) updateSubject,
    required TResult Function(String text) addText,
    required TResult Function(int id) deleteMessage,
    required TResult Function(int id, String text) updateTextMessage,
  }) {
    return updateTextMessage(id, text);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? refresh,
    TResult Function()? returnToUnaswered,
    TResult Function(String subject)? updateSubject,
    TResult Function(String text)? addText,
    TResult Function(int id)? deleteMessage,
    TResult Function(int id, String text)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (updateTextMessage != null) {
      return updateTextMessage(id, text);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Refresh value) refresh,
    required TResult Function(_ReturnToUnaswered value) returnToUnaswered,
    required TResult Function(_UpdateSubject value) updateSubject,
    required TResult Function(_AddText value) addText,
    required TResult Function(_DeleteMessage value) deleteMessage,
    required TResult Function(_UpdateTextMessage value) updateTextMessage,
  }) {
    return updateTextMessage(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Refresh value)? refresh,
    TResult Function(_ReturnToUnaswered value)? returnToUnaswered,
    TResult Function(_UpdateSubject value)? updateSubject,
    TResult Function(_AddText value)? addText,
    TResult Function(_DeleteMessage value)? deleteMessage,
    TResult Function(_UpdateTextMessage value)? updateTextMessage,
    required TResult orElse(),
  }) {
    if (updateTextMessage != null) {
      return updateTextMessage(this);
    }
    return orElse();
  }
}

abstract class _UpdateTextMessage implements ChatEvent {
  const factory _UpdateTextMessage(int id, String text) = _$_UpdateTextMessage;

  int get id => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$UpdateTextMessageCopyWith<_UpdateTextMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ChatStateTearOff {
  const _$ChatStateTearOff();

  _State call(Chat chat,
      {Rejection? rejection,
      bool isInProgress = false,
      bool isSuccess = false}) {
    return _State(
      chat,
      rejection: rejection,
      isInProgress: isInProgress,
      isSuccess: isSuccess,
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
const $ChatState = _$ChatStateTearOff();

/// @nodoc
mixin _$ChatState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)
        $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)?
        $default, {
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
abstract class $ChatStateCopyWith<$Res> {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) then) =
      _$ChatStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ChatStateCopyWithImpl<$Res> implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._value, this._then);

  final ChatState _value;
  // ignore: unused_field
  final $Res Function(ChatState) _then;
}

/// @nodoc
abstract class _$StateCopyWith<$Res> {
  factory _$StateCopyWith(_State value, $Res Function(_State) then) =
      __$StateCopyWithImpl<$Res>;
  $Res call(
      {Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess});

  $ChatCopyWith<$Res> get chat;
  $RejectionCopyWith<$Res>? get rejection;
}

/// @nodoc
class __$StateCopyWithImpl<$Res> extends _$ChatStateCopyWithImpl<$Res>
    implements _$StateCopyWith<$Res> {
  __$StateCopyWithImpl(_State _value, $Res Function(_State) _then)
      : super(_value, (v) => _then(v as _State));

  @override
  _State get _value => super._value as _State;

  @override
  $Res call({
    Object? chat = freezed,
    Object? rejection = freezed,
    Object? isInProgress = freezed,
    Object? isSuccess = freezed,
  }) {
    return _then(_State(
      chat == freezed
          ? _value.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as Chat,
      rejection: rejection == freezed
          ? _value.rejection
          : rejection // ignore: cast_nullable_to_non_nullable
              as Rejection?,
      isInProgress: isInProgress == freezed
          ? _value.isInProgress
          : isInProgress // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: isSuccess == freezed
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $ChatCopyWith<$Res> get chat {
    return $ChatCopyWith<$Res>(_value.chat, (value) {
      return _then(_value.copyWith(chat: value));
    });
  }

  @override
  $RejectionCopyWith<$Res>? get rejection {
    if (_value.rejection == null) {
      return null;
    }

    return $RejectionCopyWith<$Res>(_value.rejection!, (value) {
      return _then(_value.copyWith(rejection: value));
    });
  }
}

/// @nodoc
class _$_State implements _State {
  const _$_State(this.chat,
      {this.rejection, this.isInProgress = false, this.isSuccess = false});

  @override
  final Chat chat;
  @override
  final Rejection? rejection;
  @JsonKey(defaultValue: false)
  @override
  final bool isInProgress;
  @JsonKey(defaultValue: false)
  @override
  final bool isSuccess;

  @override
  String toString() {
    return 'ChatState(chat: $chat, rejection: $rejection, isInProgress: $isInProgress, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _State &&
            (identical(other.chat, chat) ||
                const DeepCollectionEquality().equals(other.chat, chat)) &&
            (identical(other.rejection, rejection) ||
                const DeepCollectionEquality()
                    .equals(other.rejection, rejection)) &&
            (identical(other.isInProgress, isInProgress) ||
                const DeepCollectionEquality()
                    .equals(other.isInProgress, isInProgress)) &&
            (identical(other.isSuccess, isSuccess) ||
                const DeepCollectionEquality()
                    .equals(other.isSuccess, isSuccess)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(chat) ^
      const DeepCollectionEquality().hash(rejection) ^
      const DeepCollectionEquality().hash(isInProgress) ^
      const DeepCollectionEquality().hash(isSuccess);

  @JsonKey(ignore: true)
  @override
  _$StateCopyWith<_State> get copyWith =>
      __$StateCopyWithImpl<_State>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)
        $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return $default(chat, rejection, isInProgress, isSuccess);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)?
        $default, {
    TResult Function()? inProgress,
    TResult Function(Rejection rejection)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(chat, rejection, isInProgress, isSuccess);
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

abstract class _State implements ChatState {
  const factory _State(Chat chat,
      {Rejection? rejection, bool isInProgress, bool isSuccess}) = _$_State;

  Chat get chat => throw _privateConstructorUsedError;
  Rejection? get rejection => throw _privateConstructorUsedError;
  bool get isInProgress => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
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
class __$InProgressCopyWithImpl<$Res> extends _$ChatStateCopyWithImpl<$Res>
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
    return 'ChatState.inProgress()';
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
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)
        $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return inProgress();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)?
        $default, {
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

abstract class _InProgress implements ChatState {
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
class __$ErrorCopyWithImpl<$Res> extends _$ChatStateCopyWithImpl<$Res>
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
    return 'ChatState.error(rejection: $rejection)';
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
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)
        $default, {
    required TResult Function() inProgress,
    required TResult Function(Rejection rejection) error,
  }) {
    return error(rejection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            Chat chat, Rejection? rejection, bool isInProgress, bool isSuccess)?
        $default, {
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

abstract class _Error implements ChatState {
  const factory _Error(Rejection rejection) = _$_Error;

  Rejection get rejection => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}
