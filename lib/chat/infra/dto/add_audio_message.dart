import 'package:askimam/common/domain/model/model.dart';

class AddAudioMessage with Model {
  final int chatId;
  final String audio;
  final String duration;
  final String fcmToken;

  const AddAudioMessage(this.chatId, this.audio, this.duration, this.fcmToken);

  @override
  Map<String, dynamic> toJson() => {
        'chatId': chatId,
        'audio': audio,
        'duration': duration,
        'fcmToken': fcmToken,
      };
}
