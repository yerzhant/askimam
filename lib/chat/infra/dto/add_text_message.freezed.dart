// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'add_text_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddTextMessage _$AddTextMessageFromJson(Map<String, dynamic> json) {
  return _AddTextMessage.fromJson(json);
}

/// @nodoc
class _$AddTextMessageTearOff {
  const _$AddTextMessageTearOff();

  _AddTextMessage call(int chatId, String text, String fcmToken) {
    return _AddTextMessage(
      chatId,
      text,
      fcmToken,
    );
  }

  AddTextMessage fromJson(Map<String, Object> json) {
    return AddTextMessage.fromJson(json);
  }
}

/// @nodoc
const $AddTextMessage = _$AddTextMessageTearOff();

/// @nodoc
mixin _$AddTextMessage {
  int get chatId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddTextMessageCopyWith<AddTextMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddTextMessageCopyWith<$Res> {
  factory $AddTextMessageCopyWith(
          AddTextMessage value, $Res Function(AddTextMessage) then) =
      _$AddTextMessageCopyWithImpl<$Res>;
  $Res call({int chatId, String text, String fcmToken});
}

/// @nodoc
class _$AddTextMessageCopyWithImpl<$Res>
    implements $AddTextMessageCopyWith<$Res> {
  _$AddTextMessageCopyWithImpl(this._value, this._then);

  final AddTextMessage _value;
  // ignore: unused_field
  final $Res Function(AddTextMessage) _then;

  @override
  $Res call({
    Object? chatId = freezed,
    Object? text = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AddTextMessageCopyWith<$Res>
    implements $AddTextMessageCopyWith<$Res> {
  factory _$AddTextMessageCopyWith(
          _AddTextMessage value, $Res Function(_AddTextMessage) then) =
      __$AddTextMessageCopyWithImpl<$Res>;
  @override
  $Res call({int chatId, String text, String fcmToken});
}

/// @nodoc
class __$AddTextMessageCopyWithImpl<$Res>
    extends _$AddTextMessageCopyWithImpl<$Res>
    implements _$AddTextMessageCopyWith<$Res> {
  __$AddTextMessageCopyWithImpl(
      _AddTextMessage _value, $Res Function(_AddTextMessage) _then)
      : super(_value, (v) => _then(v as _AddTextMessage));

  @override
  _AddTextMessage get _value => super._value as _AddTextMessage;

  @override
  $Res call({
    Object? chatId = freezed,
    Object? text = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_AddTextMessage(
      chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
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
class _$_AddTextMessage implements _AddTextMessage {
  _$_AddTextMessage(this.chatId, this.text, this.fcmToken);

  factory _$_AddTextMessage.fromJson(Map<String, dynamic> json) =>
      _$_$_AddTextMessageFromJson(json);

  @override
  final int chatId;
  @override
  final String text;
  @override
  final String fcmToken;

  @override
  String toString() {
    return 'AddTextMessage(chatId: $chatId, text: $text, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddTextMessage &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality()
                    .equals(other.fcmToken, fcmToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(fcmToken);

  @JsonKey(ignore: true)
  @override
  _$AddTextMessageCopyWith<_AddTextMessage> get copyWith =>
      __$AddTextMessageCopyWithImpl<_AddTextMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AddTextMessageToJson(this);
  }
}

abstract class _AddTextMessage implements AddTextMessage {
  factory _AddTextMessage(int chatId, String text, String fcmToken) =
      _$_AddTextMessage;

  factory _AddTextMessage.fromJson(Map<String, dynamic> json) =
      _$_AddTextMessage.fromJson;

  @override
  int get chatId => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get fcmToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddTextMessageCopyWith<_AddTextMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
