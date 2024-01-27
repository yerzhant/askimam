// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'imam_ratings_with_description.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImamRatingsWithDescription _$ImamRatingsWithDescriptionFromJson(
        Map<String, dynamic> json) =>
    ImamRatingsWithDescription(
      json['description'] as String,
      (json['ratings'] as List<dynamic>)
          .map((e) => ImamRating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ImamRatingsWithDescriptionToJson(
        ImamRatingsWithDescription instance) =>
    <String, dynamic>{
      'description': instance.description,
      'ratings': instance.ratings,
    };
