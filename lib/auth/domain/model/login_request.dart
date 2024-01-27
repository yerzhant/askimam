import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

@JsonSerializable()
class LoginRequest extends Equatable with Model {
  final String login;
  final String password;
  final String fcmToken;

  const LoginRequest(this.login, this.password, this.fcmToken);

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @override
  List<Object?> get props => [login, password, fcmToken];
}
