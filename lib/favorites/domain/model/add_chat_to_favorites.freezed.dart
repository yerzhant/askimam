// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'add_chat_to_favorites.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddChatToFavorites _$AddChatToFavoritesFromJson(Map<String, dynamic> json) {
  return _AddChatToFavorites.fromJson(json);
}

/// @nodoc
class _$AddChatToFavoritesTearOff {
  const _$AddChatToFavoritesTearOff();

  _AddChatToFavorites call(int id) {
    return _AddChatToFavorites(
      id,
    );
  }

  AddChatToFavorites fromJson(Map<String, Object> json) {
    return AddChatToFavorites.fromJson(json);
  }
}

/// @nodoc
const $AddChatToFavorites = _$AddChatToFavoritesTearOff();

/// @nodoc
mixin _$AddChatToFavorites {
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddChatToFavoritesCopyWith<AddChatToFavorites> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddChatToFavoritesCopyWith<$Res> {
  factory $AddChatToFavoritesCopyWith(
          AddChatToFavorites value, $Res Function(AddChatToFavorites) then) =
      _$AddChatToFavoritesCopyWithImpl<$Res>;
  $Res call({int id});
}

/// @nodoc
class _$AddChatToFavoritesCopyWithImpl<$Res>
    implements $AddChatToFavoritesCopyWith<$Res> {
  _$AddChatToFavoritesCopyWithImpl(this._value, this._then);

  final AddChatToFavorites _value;
  // ignore: unused_field
  final $Res Function(AddChatToFavorites) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$AddChatToFavoritesCopyWith<$Res>
    implements $AddChatToFavoritesCopyWith<$Res> {
  factory _$AddChatToFavoritesCopyWith(
          _AddChatToFavorites value, $Res Function(_AddChatToFavorites) then) =
      __$AddChatToFavoritesCopyWithImpl<$Res>;
  @override
  $Res call({int id});
}

/// @nodoc
class __$AddChatToFavoritesCopyWithImpl<$Res>
    extends _$AddChatToFavoritesCopyWithImpl<$Res>
    implements _$AddChatToFavoritesCopyWith<$Res> {
  __$AddChatToFavoritesCopyWithImpl(
      _AddChatToFavorites _value, $Res Function(_AddChatToFavorites) _then)
      : super(_value, (v) => _then(v as _AddChatToFavorites));

  @override
  _AddChatToFavorites get _value => super._value as _AddChatToFavorites;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_AddChatToFavorites(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_AddChatToFavorites extends _AddChatToFavorites {
  _$_AddChatToFavorites(this.id) : super._();

  factory _$_AddChatToFavorites.fromJson(Map<String, dynamic> json) =>
      _$_$_AddChatToFavoritesFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'AddChatToFavorites(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AddChatToFavorites &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$AddChatToFavoritesCopyWith<_AddChatToFavorites> get copyWith =>
      __$AddChatToFavoritesCopyWithImpl<_AddChatToFavorites>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AddChatToFavoritesToJson(this);
  }
}

abstract class _AddChatToFavorites extends AddChatToFavorites {
  factory _AddChatToFavorites(int id) = _$_AddChatToFavorites;
  _AddChatToFavorites._() : super._();

  factory _AddChatToFavorites.fromJson(Map<String, dynamic> json) =
      _$_AddChatToFavorites.fromJson;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$AddChatToFavoritesCopyWith<_AddChatToFavorites> get copyWith =>
      throw _privateConstructorUsedError;
}
