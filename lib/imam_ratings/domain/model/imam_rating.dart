import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'imam_rating.freezed.dart';
part 'imam_rating.g.dart';

@freezed
class ImamRating with _$ImamRating, Model {
  factory ImamRating(
    String name,
    int rating,
  ) = _ImamRating;

  const ImamRating._();

  factory ImamRating.fromJson(Map<String, dynamic> json) =>
      _$ImamRatingFromJson(json);
}
