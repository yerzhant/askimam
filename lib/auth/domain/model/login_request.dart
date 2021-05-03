import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_request.freezed.dart';
part 'login_request.g.dart';

@freezed
class LoginRequest with _$LoginRequest, Model {
  factory LoginRequest(
    String login,
    String password,
    String fcmToken,
  ) = _LoginRequest;

  const LoginRequest._();

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
}
