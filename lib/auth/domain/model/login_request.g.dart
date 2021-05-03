// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LoginRequest _$_$_LoginRequestFromJson(Map<String, dynamic> json) {
  return _$_LoginRequest(
    json['login'] as String,
    json['password'] as String,
    json['fcmToken'] as String,
  );
}

Map<String, dynamic> _$_$_LoginRequestToJson(_$_LoginRequest instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
      'fcmToken': instance.fcmToken,
    };
