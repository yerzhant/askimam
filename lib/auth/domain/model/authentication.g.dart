// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      json['jwt'] as String,
      json['userId'] as int,
      $enumDecode(_$UserTypeEnumMap, json['userType']),
      json['fcmToken'] as String,
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'jwt': instance.jwt,
      'userId': instance.userId,
      'userType': _$UserTypeEnumMap[instance.userType]!,
      'fcmToken': instance.fcmToken,
    };

const _$UserTypeEnumMap = {
  UserType.Imam: 'Imam',
  UserType.Inquirer: 'Inquirer',
};
