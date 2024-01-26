import 'package:askimam/common/domain/model/model.dart';

class LoginRequest with Model {
  final String login;
  final String password;
  final String fcmToken;

  const LoginRequest(this.login, this.password, this.fcmToken);

  @override
  Map<String, dynamic> toJson() => {
        'login': login,
        'password': password,
        'fcmToken': fcmToken,
      };
}
