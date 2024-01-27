// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTextMessage _$AddTextMessageFromJson(Map<String, dynamic> json) =>
    AddTextMessage(
      json['chatId'] as int,
      json['text'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$AddTextMessageToJson(AddTextMessage instance) =>
    <String, dynamic>{
      'chatId': instance.chatId,
      'text': instance.text,
      'fcmToken': instance.fcmToken,
    };
