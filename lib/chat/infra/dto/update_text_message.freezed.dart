// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'update_text_message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdateTextMessage _$UpdateTextMessageFromJson(Map<String, dynamic> json) {
  return _UpdateTextMessage.fromJson(json);
}

/// @nodoc
class _$UpdateTextMessageTearOff {
  const _$UpdateTextMessageTearOff();

  _UpdateTextMessage call(String text, String fcmToken) {
    return _UpdateTextMessage(
      text,
      fcmToken,
    );
  }

  UpdateTextMessage fromJson(Map<String, Object> json) {
    return UpdateTextMessage.fromJson(json);
  }
}

/// @nodoc
const $UpdateTextMessage = _$UpdateTextMessageTearOff();

/// @nodoc
mixin _$UpdateTextMessage {
  String get text => throw _privateConstructorUsedError;
  String get fcmToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateTextMessageCopyWith<UpdateTextMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateTextMessageCopyWith<$Res> {
  factory $UpdateTextMessageCopyWith(
          UpdateTextMessage value, $Res Function(UpdateTextMessage) then) =
      _$UpdateTextMessageCopyWithImpl<$Res>;
  $Res call({String text, String fcmToken});
}

/// @nodoc
class _$UpdateTextMessageCopyWithImpl<$Res>
    implements $UpdateTextMessageCopyWith<$Res> {
  _$UpdateTextMessageCopyWithImpl(this._value, this._then);

  final UpdateTextMessage _value;
  // ignore: unused_field
  final $Res Function(UpdateTextMessage) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_value.copyWith(
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
abstract class _$UpdateTextMessageCopyWith<$Res>
    implements $UpdateTextMessageCopyWith<$Res> {
  factory _$UpdateTextMessageCopyWith(
          _UpdateTextMessage value, $Res Function(_UpdateTextMessage) then) =
      __$UpdateTextMessageCopyWithImpl<$Res>;
  @override
  $Res call({String text, String fcmToken});
}

/// @nodoc
class __$UpdateTextMessageCopyWithImpl<$Res>
    extends _$UpdateTextMessageCopyWithImpl<$Res>
    implements _$UpdateTextMessageCopyWith<$Res> {
  __$UpdateTextMessageCopyWithImpl(
      _UpdateTextMessage _value, $Res Function(_UpdateTextMessage) _then)
      : super(_value, (v) => _then(v as _UpdateTextMessage));

  @override
  _UpdateTextMessage get _value => super._value as _UpdateTextMessage;

  @override
  $Res call({
    Object? text = freezed,
    Object? fcmToken = freezed,
  }) {
    return _then(_UpdateTextMessage(
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
class _$_UpdateTextMessage extends _UpdateTextMessage {
  _$_UpdateTextMessage(this.text, this.fcmToken) : super._();

  factory _$_UpdateTextMessage.fromJson(Map<String, dynamic> json) =>
      _$_$_UpdateTextMessageFromJson(json);

  @override
  final String text;
  @override
  final String fcmToken;

  @override
  String toString() {
    return 'UpdateTextMessage(text: $text, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateTextMessage &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.fcmToken, fcmToken) ||
                const DeepCollectionEquality()
                    .equals(other.fcmToken, fcmToken)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(fcmToken);

  @JsonKey(ignore: true)
  @override
  _$UpdateTextMessageCopyWith<_UpdateTextMessage> get copyWith =>
      __$UpdateTextMessageCopyWithImpl<_UpdateTextMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UpdateTextMessageToJson(this);
  }
}

abstract class _UpdateTextMessage extends UpdateTextMessage {
  factory _UpdateTextMessage(String text, String fcmToken) =
      _$_UpdateTextMessage;
  _UpdateTextMessage._() : super._();

  factory _UpdateTextMessage.fromJson(Map<String, dynamic> json) =
      _$_UpdateTextMessage.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  String get fcmToken => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UpdateTextMessageCopyWith<_UpdateTextMessage> get copyWith =>
      throw _privateConstructorUsedError;
}
