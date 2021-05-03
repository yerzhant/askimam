import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'logout_request.freezed.dart';
part 'logout_request.g.dart';

@freezed
class LogoutRequest with _$LogoutRequest, Model {
  factory LogoutRequest(
    String fcmToken,
  ) = _LogoutRequest;

  const LogoutRequest._();

  factory LogoutRequest.fromJson(Map<String, dynamic> json) =>
      _$LogoutRequestFromJson(json);
}
