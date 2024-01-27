// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) => Chat(
      json['id'] as int,
      $enumDecode(_$ChatTypeEnumMap, json['type']),
      json['askedBy'] as int,
      json['subject'] as String,
      DateTime.parse(json['updatedAt'] as String),
      isFavorite: json['isFavorite'] as bool? ?? false,
      isViewedByImam: json['isViewedByImam'] as bool? ?? false,
      isViewedByInquirer: json['isViewedByInquirer'] as bool? ?? false,
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ChatTypeEnumMap[instance.type]!,
      'askedBy': instance.askedBy,
      'subject': instance.subject,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isFavorite': instance.isFavorite,
      'isViewedByImam': instance.isViewedByImam,
      'isViewedByInquirer': instance.isViewedByInquirer,
      'messages': instance.messages,
    };

const _$ChatTypeEnumMap = {
  ChatType.Public: 'Public',
  ChatType.Private: 'Private',
};
