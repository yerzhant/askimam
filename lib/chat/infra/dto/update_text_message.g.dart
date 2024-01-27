// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_text_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTextMessage _$UpdateTextMessageFromJson(Map<String, dynamic> json) =>
    UpdateTextMessage(
      json['text'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$UpdateTextMessageToJson(UpdateTextMessage instance) =>
    <String, dynamic>{
      'text': instance.text,
      'fcmToken': instance.fcmToken,
    };
