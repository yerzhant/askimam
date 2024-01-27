import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imam_ratings_with_description.g.dart';

@JsonSerializable()
class ImamRatingsWithDescription with Model {
  final String description;
  final List<ImamRating> ratings;

  const ImamRatingsWithDescription(this.description, this.ratings);

  factory ImamRatingsWithDescription.fromJson(Map<String, dynamic> json) =>
      _$ImamRatingsWithDescriptionFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImamRatingsWithDescriptionToJson(this);
}
