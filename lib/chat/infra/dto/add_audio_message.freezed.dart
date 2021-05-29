// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'add_audio_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddAudioMessage _$AddAudioMessageFromJson(Map<String, dynamic> json) {
  return _AddAudioMessage.fromJson(json);
}

/// @nodoc
class _$AddAudioMessageTearOff {
  const _$AddAudioMessageTearOff();

  _AddAudioMessage call(
      int chatId, String audio, String duration, String fcmToken) {
    return _AddAudioMessage(
      chatId,
      audio,
      duration,
      fcmToken,
    );
  }

  AddAudioMessage fromJson(Map<String, Object> json) {
    return AddAudioMessage.fromJson(json);
  }
}

/// @nodoc
const $AddAudioMessage = _$AddAudioMessageTearOff();

/// @nodoc
mixin _$AddAudioMessage {
  int get chatId => throw _privateConstructorUsedError;
  String get audio => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddAudioMessageCopyWith<AddAudioMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddAudioMessageCopyWith<$Res> {
  factory $AddAudioMessageCopyWith(
          AddAudioMessage value, $Res Function(AddAudioMessage) then) =
      _$AddAudioMessageCopyWithImpl<$Res>;
  $Res call({int chatId, String audio, String duration, String fcmToken});
}

/// @nodoc
class _$AddAudioMessageCopyWithImpl<$Res>
    implements $AddAudioMessageCopyWith<$Res> {
  _$AddAudioMessageCopyWithImpl(this._value, this._then);

  final AddAudioMessage _value;
  // ignore: unused_field
  final $Res Function(AddAudioMessage) _then;

  @override
  $Res call({
    Object? chatId = freezed,
    Object? audio = freezed,
    Object? duration = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
      chatId: chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      audio: audio == freezed
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as String,
      duration: duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: fcmToken == freezed
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$AddAudioMessageCopyWith<$Res>
    implements $AddAudioMessageCopyWith<$Res> {
  factory _$AddAudioMessageCopyWith(
          _AddAudioMessage value, $Res Function(_AddAudioMessage) then) =
      __$AddAudioMessageCopyWithImpl<$Res>;
  @override
  $Res call({int chatId, String audio, String duration, String fcmToken});
}

/// @nodoc
class __$AddAudioMessageCopyWithImpl<$Res>
    extends _$AddAudioMessageCopyWithImpl<$Res>
    implements _$AddAudioMessageCopyWith<$Res> {
  __$AddAudioMessageCopyWithImpl(
      _AddAudioMessage _value, $Res Function(_AddAudioMessage) _then)
      : super(_value, (v) => _then(v as _AddAudioMessage));

  @override
  _AddAudioMessage get _value => super._value as _AddAudioMessage;

  @override
  $Res call({
    Object? chatId = freezed,
    Object? audio = freezed,
    Object? duration = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_AddAudioMessage(
      chatId == freezed
          ? _value.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as int,
      audio == freezed
          ? _value.audio
          : audio // ignore: cast_nullable_to_non_nullable
              as String,
      duration == freezed
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
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
class _$_AddAudioMessage extends _AddAudioMessage {
  _$_AddAudioMessage(this.chatId, this.audio, this.duration, this.fcmToken)
      : super._();

  factory _$_AddAudioMessage.fromJson(Map<String, dynamic> json) =>
      _$_$_AddAudioMessageFromJson(json);

  @override
  final int chatId;
  @override
  final String audio;
  @override
  final String duration;
  @override
  final String fcmToken;

  @override
  String toString() {
    return 'AddAudioMessage(chatId: $chatId, audio: $audio, duration: $duration, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddAudioMessage &&
            (identical(other.chatId, chatId) ||
                const DeepCollectionEquality().equals(other.chatId, chatId)) &&
            (identical(other.audio, audio) ||
                const DeepCollectionEquality().equals(other.audio, audio)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality()
                    .equals(other.fcmToken, fcmToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(chatId) ^
      const DeepCollectionEquality().hash(audio) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(fcmToken);

  @JsonKey(ignore: true)
  @override
  _$AddAudioMessageCopyWith<_AddAudioMessage> get copyWith =>
      __$AddAudioMessageCopyWithImpl<_AddAudioMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AddAudioMessageToJson(this);
  }
}

abstract class _AddAudioMessage extends AddAudioMessage {
  factory _AddAudioMessage(
          int chatId, String audio, String duration, String fcmToken) =
      _$_AddAudioMessage;
  _AddAudioMessage._() : super._();

  factory _AddAudioMessage.fromJson(Map<String, dynamic> json) =
      _$_AddAudioMessage.fromJson;

  @override
  int get chatId => throw _privateConstructorUsedError;
  @override
  String get audio => throw _privateConstructorUsedError;
  @override
  String get duration => throw _privateConstructorUsedError;
  @override
  String get fcmToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddAudioMessageCopyWith<_AddAudioMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
