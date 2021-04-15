import 'dart:convert';

import 'package:askimam/common/domain/rejection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
abstract class ApiResponse with _$ApiResponse {
  factory ApiResponse(
    ApiResponseStatus status, {
    String? error,
  }) = _ApiResponse;

  factory ApiResponse.ok() => ApiResponse(ApiResponseStatus.Ok);
  factory ApiResponse.error(String error) => ApiResponse(
        ApiResponseStatus.Error,
        error: error,
      );

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);
}

enum ApiResponseStatus { Ok, Error }

extension ApiResponseExt on ApiResponse {
  String toJsonString() => jsonEncode(toJson());

  Rejection toRejection() => Rejection(error ?? 'Unknown error.');
}

extension StringExt on String {
  ApiResponse decodeApiResponse() => ApiResponse.fromJson(jsonDecode(this));
}
