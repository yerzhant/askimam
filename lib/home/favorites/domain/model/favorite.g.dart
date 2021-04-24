// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Favorite _$_$_FavoriteFromJson(Map<String, dynamic> json) {
  return _$_Favorite(
    json['id'] as int,
    json['chatId'] as int,
    json['subject'] as String,
  );
}

Map<String, dynamic> _$_$_FavoriteToJson(_$_Favorite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chatId': instance.chatId,
      'subject': instance.subject,
    };
