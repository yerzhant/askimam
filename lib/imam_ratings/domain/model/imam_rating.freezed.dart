// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'imam_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImamRating _$ImamRatingFromJson(Map<String, dynamic> json) {
  return _ImamRating.fromJson(json);
}

/// @nodoc
class _$ImamRatingTearOff {
  const _$ImamRatingTearOff();

  _ImamRating call(String name, int rating) {
    return _ImamRating(
      name,
      rating,
    );
  }

  ImamRating fromJson(Map<String, Object> json) {
    return ImamRating.fromJson(json);
  }
}

/// @nodoc
const $ImamRating = _$ImamRatingTearOff();

/// @nodoc
mixin _$ImamRating {
  String get name => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImamRatingCopyWith<ImamRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImamRatingCopyWith<$Res> {
  factory $ImamRatingCopyWith(
          ImamRating value, $Res Function(ImamRating) then) =
      _$ImamRatingCopyWithImpl<$Res>;
  $Res call({String name, int rating});
}

/// @nodoc
class _$ImamRatingCopyWithImpl<$Res> implements $ImamRatingCopyWith<$Res> {
  _$ImamRatingCopyWithImpl(this._value, this._then);

  final ImamRating _value;
  // ignore: unused_field
  final $Res Function(ImamRating) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? rating = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rating: rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ImamRatingCopyWith<$Res> implements $ImamRatingCopyWith<$Res> {
  factory _$ImamRatingCopyWith(
          _ImamRating value, $Res Function(_ImamRating) then) =
      __$ImamRatingCopyWithImpl<$Res>;
  @override
  $Res call({String name, int rating});
}

/// @nodoc
class __$ImamRatingCopyWithImpl<$Res> extends _$ImamRatingCopyWithImpl<$Res>
    implements _$ImamRatingCopyWith<$Res> {
  __$ImamRatingCopyWithImpl(
      _ImamRating _value, $Res Function(_ImamRating) _then)
      : super(_value, (v) => _then(v as _ImamRating));

  @override
  _ImamRating get _value => super._value as _ImamRating;

  @override
  $Res call({
    Object? name = freezed,
    Object? rating = freezed,
  }) {
    return _then(_ImamRating(
      name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      rating == freezed
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ImamRating implements _ImamRating {
  _$_ImamRating(this.name, this.rating);

  factory _$_ImamRating.fromJson(Map<String, dynamic> json) =>
      _$_$_ImamRatingFromJson(json);

  @override
  final String name;
  @override
  final int rating;

  @override
  String toString() {
    return 'ImamRating(name: $name, rating: $rating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ImamRating &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.rating, rating) ||
                const DeepCollectionEquality().equals(other.rating, rating)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(rating);

  @JsonKey(ignore: true)
  @override
  _$ImamRatingCopyWith<_ImamRating> get copyWith =>
      __$ImamRatingCopyWithImpl<_ImamRating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ImamRatingToJson(this);
  }
}

abstract class _ImamRating implements ImamRating {
  factory _ImamRating(String name, int rating) = _$_ImamRating;

  factory _ImamRating.fromJson(Map<String, dynamic> json) =
      _$_ImamRating.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  int get rating => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ImamRatingCopyWith<_ImamRating> get copyWith =>
      throw _privateConstructorUsedError;
}
