import 'package:freezed_annotation/freezed_annotation.dart';

part 'imam_rating.freezed.dart';
part 'imam_rating.g.dart';

@freezed
class ImamRating with _$ImamRating {
  factory ImamRating(
    String name,
    int rating,
  ) = _ImamRating;

  factory ImamRating.fromJson(Map<String, dynamic> json) =>
      _$ImamRatingFromJson(json);
}
