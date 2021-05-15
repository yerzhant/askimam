// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'imam_ratings_with_description.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImamRatingsWithDescription _$ImamRatingsWithDescriptionFromJson(
    Map<String, dynamic> json) {
  return _ImamRatingWithDescription.fromJson(json);
}

/// @nodoc
class _$ImamRatingsWithDescriptionTearOff {
  const _$ImamRatingsWithDescriptionTearOff();

  _ImamRatingWithDescription call(
      String description, List<ImamRating> ratings) {
    return _ImamRatingWithDescription(
      description,
      ratings,
    );
  }

  ImamRatingsWithDescription fromJson(Map<String, Object> json) {
    return ImamRatingsWithDescription.fromJson(json);
  }
}

/// @nodoc
const $ImamRatingsWithDescription = _$ImamRatingsWithDescriptionTearOff();

/// @nodoc
mixin _$ImamRatingsWithDescription {
  String get description => throw _privateConstructorUsedError;
  List<ImamRating> get ratings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImamRatingsWithDescriptionCopyWith<ImamRatingsWithDescription>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImamRatingsWithDescriptionCopyWith<$Res> {
  factory $ImamRatingsWithDescriptionCopyWith(ImamRatingsWithDescription value,
          $Res Function(ImamRatingsWithDescription) then) =
      _$ImamRatingsWithDescriptionCopyWithImpl<$Res>;
  $Res call({String description, List<ImamRating> ratings});
}

/// @nodoc
class _$ImamRatingsWithDescriptionCopyWithImpl<$Res>
    implements $ImamRatingsWithDescriptionCopyWith<$Res> {
  _$ImamRatingsWithDescriptionCopyWithImpl(this._value, this._then);

  final ImamRatingsWithDescription _value;
  // ignore: unused_field
  final $Res Function(ImamRatingsWithDescription) _then;

  @override
  $Res call({
    Object? description = freezed,
    Object? ratings = freezed,
  }) {
    return _then(_value.copyWith(
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ratings: ratings == freezed
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<ImamRating>,
    ));
  }
}

/// @nodoc
abstract class _$ImamRatingWithDescriptionCopyWith<$Res>
    implements $ImamRatingsWithDescriptionCopyWith<$Res> {
  factory _$ImamRatingWithDescriptionCopyWith(_ImamRatingWithDescription value,
          $Res Function(_ImamRatingWithDescription) then) =
      __$ImamRatingWithDescriptionCopyWithImpl<$Res>;
  @override
  $Res call({String description, List<ImamRating> ratings});
}

/// @nodoc
class __$ImamRatingWithDescriptionCopyWithImpl<$Res>
    extends _$ImamRatingsWithDescriptionCopyWithImpl<$Res>
    implements _$ImamRatingWithDescriptionCopyWith<$Res> {
  __$ImamRatingWithDescriptionCopyWithImpl(_ImamRatingWithDescription _value,
      $Res Function(_ImamRatingWithDescription) _then)
      : super(_value, (v) => _then(v as _ImamRatingWithDescription));

  @override
  _ImamRatingWithDescription get _value =>
      super._value as _ImamRatingWithDescription;

  @override
  $Res call({
    Object? description = freezed,
    Object? ratings = freezed,
  }) {
    return _then(_ImamRatingWithDescription(
      description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      ratings == freezed
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<ImamRating>,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ImamRatingWithDescription extends _ImamRatingWithDescription {
  _$_ImamRatingWithDescription(this.description, this.ratings) : super._();

  factory _$_ImamRatingWithDescription.fromJson(Map<String, dynamic> json) =>
      _$_$_ImamRatingWithDescriptionFromJson(json);

  @override
  final String description;
  @override
  final List<ImamRating> ratings;

  @override
  String toString() {
    return 'ImamRatingsWithDescription(description: $description, ratings: $ratings)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ImamRatingWithDescription &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.ratings, ratings) ||
                const DeepCollectionEquality().equals(other.ratings, ratings)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(ratings);

  @JsonKey(ignore: true)
  @override
  _$ImamRatingWithDescriptionCopyWith<_ImamRatingWithDescription>
      get copyWith =>
          __$ImamRatingWithDescriptionCopyWithImpl<_ImamRatingWithDescription>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ImamRatingWithDescriptionToJson(this);
  }
}

abstract class _ImamRatingWithDescription extends ImamRatingsWithDescription {
  factory _ImamRatingWithDescription(
          String description, List<ImamRating> ratings) =
      _$_ImamRatingWithDescription;
  _ImamRatingWithDescription._() : super._();

  factory _ImamRatingWithDescription.fromJson(Map<String, dynamic> json) =
      _$_ImamRatingWithDescription.fromJson;

  @override
  String get description => throw _privateConstructorUsedError;
  @override
  List<ImamRating> get ratings => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ImamRatingWithDescriptionCopyWith<_ImamRatingWithDescription>
      get copyWith => throw _privateConstructorUsedError;
}
