// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$_$_ChatFromJson(Map<String, dynamic> json) {
  return _$_Chat(
    json['id'] as int,
    _$enumDecode(_$ChatTypeEnumMap, json['type']),
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
}

Map<String, dynamic> _$_$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$ChatTypeEnumMap[instance.type],
      'askedBy': instance.askedBy,
      'subject': instance.subject,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isFavorite': instance.isFavorite,
      'isViewedByImam': instance.isViewedByImam,
      'isViewedByInquirer': instance.isViewedByInquirer,
      'messages': instance.messages,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$ChatTypeEnumMap = {
  ChatType.Public: 'Public',
  ChatType.Private: 'Private',
};
