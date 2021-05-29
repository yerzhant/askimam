// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_audio_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddAudioMessage _$_$_AddAudioMessageFromJson(Map<String, dynamic> json) {
  return _$_AddAudioMessage(
    json['chatId'] as int,
    json['audio'] as String,
    json['duration'] as String,
    json['fcmToken'] as String,
  );
}

Map<String, dynamic> _$_$_AddAudioMessageToJson(_$_AddAudioMessage instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'audio': instance.audio,
      'duration': instance.duration,
      'fcmToken': instance.fcmToken,
    };
