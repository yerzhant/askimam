import 'package:askimam/common/domain/model/model.dart';

class LogoutRequest with Model {
  final String fcmToken;

  const LogoutRequest(this.fcmToken);

  @override
  Map<String, dynamic> toJson() => {
        'fcmToken': fcmToken,
      };
}
