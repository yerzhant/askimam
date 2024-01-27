import 'package:askimam/common/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logout_request.g.dart';

@JsonSerializable()
class LogoutRequest with Model {
  final String fcmToken;

  const LogoutRequest(this.fcmToken);

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LogoutRequestToJson(this);
}
