// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddTextMessage _$_$_AddTextMessageFromJson(Map<String, dynamic> json) {
  return _$_AddTextMessage(
    json['chatId'] as int,
    json['text'] as String,
    json['fcmToken'] as String,
  );
}

Map<String, dynamic> _$_$_AddTextMessageToJson(_$_AddTextMessage instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'text': instance.text,
      'fcmToken': instance.fcmToken,
    };
