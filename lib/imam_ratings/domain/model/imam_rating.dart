import 'package:askimam/common/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'imam_rating.g.dart';

@JsonSerializable()
class ImamRating with Model {
  final String name;
  final int rating;

  const ImamRating(this.name, this.rating);

  factory ImamRating.fromJson(Map<String, dynamic> json) =>
      _$ImamRatingFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ImamRatingToJson(this);
}
