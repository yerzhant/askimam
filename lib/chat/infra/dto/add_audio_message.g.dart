// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_audio_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddAudioMessage _$AddAudioMessageFromJson(Map<String, dynamic> json) =>
    AddAudioMessage(
      json['chatId'] as int,
      json['audio'] as String,
      json['duration'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$AddAudioMessageToJson(AddAudioMessage instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'audio': instance.audio,
      'duration': instance.duration,
      'fcmToken': instance.fcmToken,
    };
