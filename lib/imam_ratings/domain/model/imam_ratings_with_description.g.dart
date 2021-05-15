// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imam_ratings_with_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ImamRatingWithDescription _$_$_ImamRatingWithDescriptionFromJson(
    Map<String, dynamic> json) {
  return _$_ImamRatingWithDescription(
    json['description'] as String,
    (json['ratings'] as List<dynamic>)
        .map((e) => ImamRating.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_ImamRatingWithDescriptionToJson(
        _$_ImamRatingWithDescription instance) =>
    <String, dynamic>{
      'description': instance.description,
      'ratings': instance.ratings,
    };
