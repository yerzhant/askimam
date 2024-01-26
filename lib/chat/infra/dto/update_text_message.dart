import 'package:askimam/common/domain/model/model.dart';

class UpdateTextMessage with Model {
  final String text;
  final String fcmToken;

  const UpdateTextMessage(this.text, this.fcmToken);

  @override
  Map<String, dynamic> toJson() => {
        'text': text,
        'fcmToken': fcmToken,
      };
}
