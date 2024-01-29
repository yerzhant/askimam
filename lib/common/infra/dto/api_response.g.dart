// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse _$ApiResponseFromJson(Map<String, dynamic> json) => ApiResponse(
      $enumDecode(_$ApiResponseStatusEnumMap, json['status']),
      data: json['data'],
      error: json['error'] as String?,
    );

Map<String, dynamic> _$ApiResponseToJson(ApiResponse instance) =>
    <String, dynamic>{
      'status': _$ApiResponseStatusEnumMap[instance.status]!,
      'data': instance.data,
      'error': instance.error,
    };

const _$ApiResponseStatusEnumMap = {
  ApiResponseStatus.Ok: 'Ok',
  ApiResponseStatus.Error: 'Error',
};
