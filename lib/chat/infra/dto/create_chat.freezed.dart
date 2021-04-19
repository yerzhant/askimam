// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'create_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreateChat _$CreateChatFromJson(Map<String, dynamic> json) {
  return _CreateChat.fromJson(json);
}

/// @nodoc
class _$CreateChatTearOff {
  const _$CreateChatTearOff();

  _CreateChat call(
      ChatType type, String? subject, String text, String fcmToken) {
    return _CreateChat(
      type,
      subject,
      text,
      fcmToken,
    );
  }

  CreateChat fromJson(Map<String, Object> json) {
    return CreateChat.fromJson(json);
  }
}

/// @nodoc
const $CreateChat = _$CreateChatTearOff();

/// @nodoc
mixin _$CreateChat {
  ChatType get type => throw _privateConstructorUsedError;
  String? get subject => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateChatCopyWith<CreateChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateChatCopyWith<$Res> {
  factory $CreateChatCopyWith(
          CreateChat value, $Res Function(CreateChat) then) =
      _$CreateChatCopyWithImpl<$Res>;
  $Res call({ChatType type, String? subject, String text, String fcmToken});
}

/// @nodoc
class _$CreateChatCopyWithImpl<$Res> implements $CreateChatCopyWith<$Res> {
  _$CreateChatCopyWithImpl(this._value, this._then);

  final CreateChat _value;
  // ignore: unused_field
  final $Res Function(CreateChat) _then;

  @override
  $Res call({
    Object? type = freezed,
    Object? subject = freezed,
    Object? text = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
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
abstract class _$CreateChatCopyWith<$Res> implements $CreateChatCopyWith<$Res> {
  factory _$CreateChatCopyWith(
          _CreateChat value, $Res Function(_CreateChat) then) =
      __$CreateChatCopyWithImpl<$Res>;
  @override
  $Res call({ChatType type, String? subject, String text, String fcmToken});
}

/// @nodoc
class __$CreateChatCopyWithImpl<$Res> extends _$CreateChatCopyWithImpl<$Res>
    implements _$CreateChatCopyWith<$Res> {
  __$CreateChatCopyWithImpl(
      _CreateChat _value, $Res Function(_CreateChat) _then)
      : super(_value, (v) => _then(v as _CreateChat));

  @override
  _CreateChat get _value => super._value as _CreateChat;

  @override
  $Res call({
    Object? type = freezed,
    Object? subject = freezed,
    Object? text = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_CreateChat(
      type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String?,
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
class _$_CreateChat extends _CreateChat {
  _$_CreateChat(this.type, this.subject, this.text, this.fcmToken) : super._();

  factory _$_CreateChat.fromJson(Map<String, dynamic> json) =>
      _$_$_CreateChatFromJson(json);

  @override
  final ChatType type;
  @override
  final String? subject;
  @override
  final String text;
  @override
  final String fcmToken;

  @override
  String toString() {
    return 'CreateChat(type: $type, subject: $subject, text: $text, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CreateChat &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality()
                    .equals(other.subject, subject)) &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality()
                    .equals(other.fcmToken, fcmToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(subject) ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(fcmToken);

  @JsonKey(ignore: true)
  @override
  _$CreateChatCopyWith<_CreateChat> get copyWith =>
      __$CreateChatCopyWithImpl<_CreateChat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CreateChatToJson(this);
  }
}

abstract class _CreateChat extends CreateChat {
  factory _CreateChat(
          ChatType type, String? subject, String text, String fcmToken) =
      _$_CreateChat;
  _CreateChat._() : super._();

  factory _CreateChat.fromJson(Map<String, dynamic> json) =
      _$_CreateChat.fromJson;

  @override
  ChatType get type => throw _privateConstructorUsedError;
  @override
  String? get subject => throw _privateConstructorUsedError;
  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get fcmToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CreateChatCopyWith<_CreateChat> get copyWith =>
      throw _privateConstructorUsedError;
}
