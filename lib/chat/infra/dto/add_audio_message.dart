import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_audio_message.freezed.dart';
part 'add_audio_message.g.dart';

@freezed
class AddAudioMessage with _$AddAudioMessage, Model {
  factory AddAudioMessage(
    int chatId,
    String audio,
    String duration,
    String fcmToken,
  ) = _AddAudioMessage;

  const AddAudioMessage._();

  factory AddAudioMessage.fromJson(Map<String, dynamic> json) =>
      _$AddAudioMessageFromJson(json);
}
