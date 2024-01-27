import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';

class ImamRatingsWithDescription {
  final String description;
  final List<ImamRating> ratings;

  const ImamRatingsWithDescription(this.description, this.ratings);

  factory ImamRatingsWithDescription.fromJson(Map<String, dynamic> json) =>
      ImamRatingsWithDescription(json['description'], json['ratings']);
}
