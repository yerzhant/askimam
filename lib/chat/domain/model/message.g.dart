// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      json['id'] as int,
      $enumDecode(_$MessageTypeEnumMap, json['type']),
      json['text'] as String,
      json['author'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      audio: json['audio'] as String?,
      duration: json['duration'] as String?,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$MessageTypeEnumMap[instance.type]!,
      'text': instance.text,
      'author': instance.author,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'audio': instance.audio,
      'duration': instance.duration,
    };

const _$MessageTypeEnumMap = {
  MessageType.Text: 'Text',
  MessageType.Audio: 'Audio',
};
