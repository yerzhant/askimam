import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'imam_ratings_with_description.freezed.dart';
part 'imam_ratings_with_description.g.dart';

@freezed
class ImamRatingsWithDescription with _$ImamRatingsWithDescription, Model {
  factory ImamRatingsWithDescription(
    String description,
    List<ImamRating> ratings,
  ) = _ImamRatingWithDescription;

  const ImamRatingsWithDescription._();

  factory ImamRatingsWithDescription.fromJson(Map<String, dynamic> json) =>
      _$ImamRatingsWithDescriptionFromJson(json);
}
