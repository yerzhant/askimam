import 'package:askimam/common/domain/model/model.dart';

class AddTextMessage with Model {
  final int chatId;
  final String text;
  final String fcmToken;

  const AddTextMessage(this.chatId, this.text, this.fcmToken);

  @override
  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'text': text,
        'fcmToken': fcmToken,
      };
}
