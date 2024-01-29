import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_fcm_token.g.dart';

@JsonSerializable()
class UpdateFcmToken extends Equatable with Model {
  @JsonKey(name: 'old')
  final String oldToken;
  @JsonKey(name: 'new')
  final String newToken;

  const UpdateFcmToken(this.oldToken, this.newToken);

  factory UpdateFcmToken.fromJson(Map<String, dynamic> json) =>
      _$UpdateFcmTokenFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateFcmTokenToJson(this);

  @override
  List<Object?> get props => [oldToken, newToken];
}
