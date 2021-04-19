// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreateChat _$_$_CreateChatFromJson(Map<String, dynamic> json) {
  return _$_CreateChat(
    _$enumDecode(_$ChatTypeEnumMap, json['type']),
    json['subject'] as String?,
    json['text'] as String,
    json['fcmToken'] as String,
  );
}

Map<String, dynamic> _$_$_CreateChatToJson(_$_CreateChat instance) =>
    <String, dynamic>{
      'type': _$ChatTypeEnumMap[instance.type],
      'subject': instance.subject,
      'text': instance.text,
      'fcmToken': instance.fcmToken,
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
