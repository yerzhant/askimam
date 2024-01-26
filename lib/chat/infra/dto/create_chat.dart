import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/model.dart';

class CreateChat with Model {
  final ChatType type;
  final String? subject;
  final String text;
  final String fcmToken;

  const CreateChat(this.type, this.subject, this.text, this.fcmToken);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'subject': subject,
        'text': text,
        'fcmToken': fcmToken,
      };
}
