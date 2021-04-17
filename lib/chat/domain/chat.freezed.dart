// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return _Chat.fromJson(json);
}

/// @nodoc
class _$ChatTearOff {
  const _$ChatTearOff();

  _Chat call(int id, String subject, bool isFavorite) {
    return _Chat(
      id,
      subject,
      isFavorite,
    );
  }

  Chat fromJson(Map<String, Object> json) {
    return Chat.fromJson(json);
  }
}

/// @nodoc
const $Chat = _$ChatTearOff();

/// @nodoc
mixin _$Chat {
  int get id => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call({int id, String subject, bool isFavorite});
}

/// @nodoc
class _$ChatCopyWithImpl<$Res> implements $ChatCopyWith<$Res> {
  _$ChatCopyWithImpl(this._value, this._then);

  final Chat _value;
  // ignore: unused_field
  final $Res Function(Chat) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? subject = freezed,
    Object? isFavorite = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) then) =
      __$ChatCopyWithImpl<$Res>;
  @override
  $Res call({int id, String subject, bool isFavorite});
}

/// @nodoc
class __$ChatCopyWithImpl<$Res> extends _$ChatCopyWithImpl<$Res>
    implements _$ChatCopyWith<$Res> {
  __$ChatCopyWithImpl(_Chat _value, $Res Function(_Chat) _then)
      : super(_value, (v) => _then(v as _Chat));

  @override
  _Chat get _value => super._value as _Chat;

  @override
  $Res call({
    Object? id = freezed,
    Object? subject = freezed,
    Object? isFavorite = freezed,
  }) {
    return _then(_Chat(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Chat implements _Chat {
  _$_Chat(this.id, this.subject, this.isFavorite);

  factory _$_Chat.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatFromJson(json);

  @override
  final int id;
  @override
  final String subject;
  @override
  final bool isFavorite;

  @override
  String toString() {
    return 'Chat(id: $id, subject: $subject, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Chat &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality()
                    .equals(other.subject, subject)) &&
            (identical(other.isFavorite, isFavorite) ||
                const DeepCollectionEquality()
                    .equals(other.isFavorite, isFavorite)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(subject) ^
      const DeepCollectionEquality().hash(isFavorite);

  @JsonKey(ignore: true)
  @override
  _$ChatCopyWith<_Chat> get copyWith =>
      __$ChatCopyWithImpl<_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatToJson(this);
  }
}

abstract class _Chat implements Chat {
  factory _Chat(int id, String subject, bool isFavorite) = _$_Chat;

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get subject => throw _privateConstructorUsedError;
  @override
  bool get isFavorite => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatCopyWith<_Chat> get copyWith => throw _privateConstructorUsedError;
}
