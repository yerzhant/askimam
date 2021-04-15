import 'dart:convert';

import 'package:askimam/common/domain/rejection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

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
  List<int> toJsonUtf8() => utf8.encode(jsonEncode(toJson()));

  Rejection toRejection() => Rejection(error ?? 'Unknown error.');
}

extension StringExt on Response {
  ApiResponse decodeApiResponse() =>
      ApiResponse.fromJson(jsonDecode(utf8.decode(bodyBytes)));
}
