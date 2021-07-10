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

  _Chat call(
      int id, ChatType type, int askedBy, String subject, DateTime updatedAt,
      {bool isFavorite = false,
      bool isViewedByImam = false,
      bool isViewedByInquirer = false,
      List<Message>? messages}) {
    return _Chat(
      id,
      type,
      askedBy,
      subject,
      updatedAt,
      isFavorite: isFavorite,
      isViewedByImam: isViewedByImam,
      isViewedByInquirer: isViewedByInquirer,
      messages: messages,
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
  ChatType get type => throw _privateConstructorUsedError;
  int get askedBy => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;
  bool get isViewedByImam => throw _privateConstructorUsedError;
  bool get isViewedByInquirer => throw _privateConstructorUsedError;
  List<Message>? get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatCopyWith<Chat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatCopyWith<$Res> {
  factory $ChatCopyWith(Chat value, $Res Function(Chat) then) =
      _$ChatCopyWithImpl<$Res>;
  $Res call(
      {int id,
      ChatType type,
      int askedBy,
      String subject,
      DateTime updatedAt,
      bool isFavorite,
      bool isViewedByImam,
      bool isViewedByInquirer,
      List<Message>? messages});
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
    Object? type = freezed,
    Object? askedBy = freezed,
    Object? subject = freezed,
    Object? updatedAt = freezed,
    Object? isFavorite = freezed,
    Object? isViewedByImam = freezed,
    Object? isViewedByInquirer = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      askedBy: askedBy == freezed
          ? _value.askedBy
          : askedBy // ignore: cast_nullable_to_non_nullable
              as int,
      subject: subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      isViewedByImam: isViewedByImam == freezed
          ? _value.isViewedByImam
          : isViewedByImam // ignore: cast_nullable_to_non_nullable
              as bool,
      isViewedByInquirer: isViewedByInquirer == freezed
          ? _value.isViewedByInquirer
          : isViewedByInquirer // ignore: cast_nullable_to_non_nullable
              as bool,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
    ));
  }
}

/// @nodoc
abstract class _$ChatCopyWith<$Res> implements $ChatCopyWith<$Res> {
  factory _$ChatCopyWith(_Chat value, $Res Function(_Chat) then) =
      __$ChatCopyWithImpl<$Res>;
  @override
  $Res call(
      {int id,
      ChatType type,
      int askedBy,
      String subject,
      DateTime updatedAt,
      bool isFavorite,
      bool isViewedByImam,
      bool isViewedByInquirer,
      List<Message>? messages});
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
    Object? type = freezed,
    Object? askedBy = freezed,
    Object? subject = freezed,
    Object? updatedAt = freezed,
    Object? isFavorite = freezed,
    Object? isViewedByImam = freezed,
    Object? isViewedByInquirer = freezed,
    Object? messages = freezed,
  }) {
    return _then(_Chat(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ChatType,
      askedBy == freezed
          ? _value.askedBy
          : askedBy // ignore: cast_nullable_to_non_nullable
              as int,
      subject == freezed
          ? _value.subject
          : subject // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isFavorite: isFavorite == freezed
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
      isViewedByImam: isViewedByImam == freezed
          ? _value.isViewedByImam
          : isViewedByImam // ignore: cast_nullable_to_non_nullable
              as bool,
      isViewedByInquirer: isViewedByInquirer == freezed
          ? _value.isViewedByInquirer
          : isViewedByInquirer // ignore: cast_nullable_to_non_nullable
              as bool,
      messages: messages == freezed
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<Message>?,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Chat extends _Chat {
  _$_Chat(this.id, this.type, this.askedBy, this.subject, this.updatedAt,
      {this.isFavorite = false,
      this.isViewedByImam = false,
      this.isViewedByInquirer = false,
      this.messages})
      : super._();

  factory _$_Chat.fromJson(Map<String, dynamic> json) =>
      _$_$_ChatFromJson(json);

  @override
  final int id;
  @override
  final ChatType type;
  @override
  final int askedBy;
  @override
  final String subject;
  @override
  final DateTime updatedAt;
  @JsonKey(defaultValue: false)
  @override
  final bool isFavorite;
  @JsonKey(defaultValue: false)
  @override
  final bool isViewedByImam;
  @JsonKey(defaultValue: false)
  @override
  final bool isViewedByInquirer;
  @override
  final List<Message>? messages;

  @override
  String toString() {
    return 'Chat(id: $id, type: $type, askedBy: $askedBy, subject: $subject, updatedAt: $updatedAt, isFavorite: $isFavorite, isViewedByImam: $isViewedByImam, isViewedByInquirer: $isViewedByInquirer, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Chat &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.askedBy, askedBy) ||
                const DeepCollectionEquality()
                    .equals(other.askedBy, askedBy)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality()
                    .equals(other.subject, subject)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.isFavorite, isFavorite) ||
                const DeepCollectionEquality()
                    .equals(other.isFavorite, isFavorite)) &&
            (identical(other.isViewedByImam, isViewedByImam) ||
                const DeepCollectionEquality()
                    .equals(other.isViewedByImam, isViewedByImam)) &&
            (identical(other.isViewedByInquirer, isViewedByInquirer) ||
                const DeepCollectionEquality()
                    .equals(other.isViewedByInquirer, isViewedByInquirer)) &&
            (identical(other.messages, messages) ||
                const DeepCollectionEquality()
                    .equals(other.messages, messages)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(askedBy) ^
      const DeepCollectionEquality().hash(subject) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(isFavorite) ^
      const DeepCollectionEquality().hash(isViewedByImam) ^
      const DeepCollectionEquality().hash(isViewedByInquirer) ^
      const DeepCollectionEquality().hash(messages);

  @JsonKey(ignore: true)
  @override
  _$ChatCopyWith<_Chat> get copyWith =>
      __$ChatCopyWithImpl<_Chat>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ChatToJson(this);
  }
}

abstract class _Chat extends Chat {
  factory _Chat(
      int id, ChatType type, int askedBy, String subject, DateTime updatedAt,
      {bool isFavorite,
      bool isViewedByImam,
      bool isViewedByInquirer,
      List<Message>? messages}) = _$_Chat;
  _Chat._() : super._();

  factory _Chat.fromJson(Map<String, dynamic> json) = _$_Chat.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  ChatType get type => throw _privateConstructorUsedError;
  @override
  int get askedBy => throw _privateConstructorUsedError;
  @override
  String get subject => throw _privateConstructorUsedError;
  @override
  DateTime get updatedAt => throw _privateConstructorUsedError;
  @override
  bool get isFavorite => throw _privateConstructorUsedError;
  @override
  bool get isViewedByImam => throw _privateConstructorUsedError;
  @override
  bool get isViewedByInquirer => throw _privateConstructorUsedError;
  @override
  List<Message>? get messages => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ChatCopyWith<_Chat> get copyWith => throw _privateConstructorUsedError;
}
