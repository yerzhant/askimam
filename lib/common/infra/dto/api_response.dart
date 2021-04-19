import 'dart:convert';

import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/domain/model/favorite.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
abstract class ApiResponse with _$ApiResponse {
  const ApiResponse._();

  const factory ApiResponse(
    ApiResponseStatus status, {
    Object? data,
    String? error,
  }) = _ApiResponse;

  factory ApiResponse.ok() => ApiResponse(ApiResponseStatus.Ok);

  factory ApiResponse.data(Object data) => ApiResponse(
        ApiResponseStatus.Ok,
        data: data,
      );

  factory ApiResponse.error(String error) => ApiResponse(
        ApiResponseStatus.Error,
        error: error,
      );

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  String toJsonString() => jsonEncode(toJson());
  List<int> toJsonUtf8() => utf8.encode(jsonEncode(toJson()));

  List<T> list<T extends Model>() {
    final factories = <Type, Function>{
      Favorite: (json) => Favorite.fromJson(json),
    };

    final list = data as List<dynamic>;
    return list.map((e) => factories[T]!(e) as T).toList();
  }

  Rejection asRejection() => Rejection(error ?? 'Unknown error.');
}

enum ApiResponseStatus { Ok, Error }

extension StringExt on Response {
  ApiResponse decodeApiResponse() =>
      ApiResponse.fromJson(jsonDecode(utf8.decode(bodyBytes)));

  Rejection asRejection() => Rejection('Response: $statusCode, $reasonPhrase');
}
