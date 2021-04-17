// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$_$_ChatFromJson(Map<String, dynamic> json) {
  return _$_Chat(
    json['id'] as int,
    json['subject'] as String,
    json['isFavorite'] as bool,
  );
}

Map<String, dynamic> _$_$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'isFavorite': instance.isFavorite,
    };
