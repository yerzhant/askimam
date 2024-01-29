// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateChat _$CreateChatFromJson(Map<String, dynamic> json) => CreateChat(
      $enumDecode(_$ChatTypeEnumMap, json['type']),
      json['subject'] as String?,
      json['text'] as String,
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$CreateChatToJson(CreateChat instance) =>
    <String, dynamic>{
      'type': _$ChatTypeEnumMap[instance.type]!,
      'subject': instance.subject,
      'text': instance.text,
      'fcmToken': instance.fcmToken,
    };

const _$ChatTypeEnumMap = {
  ChatType.Public: 'Public',
  ChatType.Private: 'Private',
};
