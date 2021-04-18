// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Authentication _$_$_AuthenticationFromJson(Map<String, dynamic> json) {
  return _$_Authentication(
    json['jwt'] as String,
    _$enumDecode(_$UserTypeEnumMap, json['userType']),
  );
}

Map<String, dynamic> _$_$_AuthenticationToJson(_$_Authentication instance) =>
    <String, dynamic>{
      'jwt': instance.jwt,
      'userType': _$UserTypeEnumMap[instance.userType],
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

const _$UserTypeEnumMap = {
  UserType.Imam: 'Imam',
  UserType.Inquirer: 'Inquirer',
};
