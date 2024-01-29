import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_audio_message.g.dart';

@JsonSerializable()
class AddAudioMessage extends Equatable with Model {
  final int chatId;
  final String audio;
  final String duration;
  final String fcmToken;

  const AddAudioMessage(this.chatId, this.audio, this.duration, this.fcmToken);

  factory AddAudioMessage.fromJson(Map<String, dynamic> json) =>
      _$AddAudioMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddAudioMessageToJson(this);

  @override
  List<Object?> get props => [chatId, audio, duration, fcmToken];
}
