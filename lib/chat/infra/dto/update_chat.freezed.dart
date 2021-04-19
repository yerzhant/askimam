// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'update_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdateChat _$UpdateChatFromJson(Map<String, dynamic> json) {
  return _UpdateChat.fromJson(json);
}

/// @nodoc
class _$UpdateChatTearOff {
  const _$UpdateChatTearOff();

  _UpdateChat call(String subject) {
    return _UpdateChat(
      subject,
    );
  }

  UpdateChat fromJson(Map<String, Object> json) {
    return UpdateChat.fromJson(json);
  }
}

/// @nodoc
const $UpdateChat = _$UpdateChatTearOff();

/// @nodoc
mixin _$UpdateChat {
  String get subject => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateChatCopyWith<UpdateChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateChatCopyWith<$Res> {
  factory $UpdateChatCopyWith(
          UpdateChat value, $Res Function(UpdateChat) then) =
      _$UpdateChatCopyWithImpl<$Res>;
  $Res call({String subject});
}

/// @nodoc
class _$UpdateChatCopyWithImpl<$Res> implements $UpdateChatCopyWith<$Res> {
  _$UpdateChatCopyWithImpl(this._value, this._then);

  final UpdateChat _value;
  // ignore: unused_field
  final $Res Function(UpdateChat) _then;

  @override
  $Res call({
    Object? subject = freezed,
  }) {
    return _then(_value.copyWith(
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UpdateChatCopyWith<$Res> implements $UpdateChatCopyWith<$Res> {
  factory _$UpdateChatCopyWith(
          _UpdateChat value, $Res Function(_UpdateChat) then) =
      __$UpdateChatCopyWithImpl<$Res>;
  @override
  $Res call({String subject});
}

/// @nodoc
class __$UpdateChatCopyWithImpl<$Res> extends _$UpdateChatCopyWithImpl<$Res>
    implements _$UpdateChatCopyWith<$Res> {
  __$UpdateChatCopyWithImpl(
      _UpdateChat _value, $Res Function(_UpdateChat) _then)
      : super(_value, (v) => _then(v as _UpdateChat));

  @override
  _UpdateChat get _value => super._value as _UpdateChat;

  @override
  $Res call({
    Object? subject = freezed,
  }) {
    return _then(_UpdateChat(
      subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_UpdateChat implements _UpdateChat {
  _$_UpdateChat(this.subject);

  factory _$_UpdateChat.fromJson(Map<String, dynamic> json) =>
      _$_$_UpdateChatFromJson(json);

  @override
  final String subject;

  @override
  String toString() {
    return 'UpdateChat(subject: $subject)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UpdateChat &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality().equals(other.subject, subject)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(subject);

  @JsonKey(ignore: true)
  @override
  _$UpdateChatCopyWith<_UpdateChat> get copyWith =>
      __$UpdateChatCopyWithImpl<_UpdateChat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_UpdateChatToJson(this);
  }
}

abstract class _UpdateChat implements UpdateChat {
  factory _UpdateChat(String subject) = _$_UpdateChat;

  factory _UpdateChat.fromJson(Map<String, dynamic> json) =
      _$_UpdateChat.fromJson;

  @override
  String get subject => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UpdateChatCopyWith<_UpdateChat> get copyWith =>
      throw _privateConstructorUsedError;
}
