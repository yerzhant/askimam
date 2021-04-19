// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthenticationRequest _$_$_AuthenticationRequestFromJson(
    Map<String, dynamic> json) {
  return _$_AuthenticationRequest(
    json['login'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$_$_AuthenticationRequestToJson(
        _$_AuthenticationRequest instance) =>
    <String, dynamic>{
      'login': instance.login,
      'password': instance.password,
    };
