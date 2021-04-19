// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ApiResponse _$_$_ApiResponseFromJson(Map<String, dynamic> json) {
  return _$_ApiResponse(
    _$enumDecode(_$ApiResponseStatusEnumMap, json['status']),
    data: json['data'],
    error: json['error'] as String?,
  );
}

Map<String, dynamic> _$_$_ApiResponseToJson(_$_ApiResponse instance) =>
    <String, dynamic>{
      'status': _$ApiResponseStatusEnumMap[instance.status],
      'data': instance.data,
      'error': instance.error,
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

const _$ApiResponseStatusEnumMap = {
  ApiResponseStatus.Ok: 'Ok',
  ApiResponseStatus.Error: 'Error',
};
