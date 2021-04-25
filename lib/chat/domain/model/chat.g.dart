// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$_$_ChatFromJson(Map<String, dynamic> json) {
  return _$_Chat(
    json['id'] as int,
    json['askedBy'] as int,
    json['subject'] as String,
    isFavorite: json['isFavorite'] as bool? ?? false,
    messages: (json['messages'] as List<dynamic>?)
        ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'id': instance.id,
      'askedBy': instance.askedBy,
      'subject': instance.subject,
      'isFavorite': instance.isFavorite,
      'messages': instance.messages,
    };
