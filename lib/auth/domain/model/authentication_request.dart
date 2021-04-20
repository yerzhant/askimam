import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_request.freezed.dart';
part 'authentication_request.g.dart';

@freezed
class AuthenticationRequest with _$AuthenticationRequest, Model {
  const AuthenticationRequest._();

  factory AuthenticationRequest(
    String login,
    String password,
  ) = _AuthenticationRequest;

  factory AuthenticationRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationRequestFromJson(json);
}
