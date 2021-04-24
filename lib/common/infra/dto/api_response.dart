import 'dart:convert';

import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@freezed
abstract class ApiResponse with _$ApiResponse {
  const factory ApiResponse(
    ApiResponseStatus status, {
    Object? data,
    String? error,
  }) = _ApiResponse;

  const ApiResponse._();

  factory ApiResponse.ok() => const ApiResponse(ApiResponseStatus.Ok);

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

  M value<M extends Model>() {
    return _fromJsonfactories[M]!(data);
  }

  List<M> list<M extends Model>() {
    // ignore: cast_nullable_to_non_nullable
    final list = data as List<dynamic>;
    return list.map((e) => _fromJsonfactories[M]!(e) as M).toList();
  }

  Rejection asRejection() => Rejection(error ?? 'Unknown error.');
}

// ignore: constant_identifier_names
enum ApiResponseStatus { Ok, Error }

final _fromJsonfactories = <Type, Function>{
  Favorite: (json) => Favorite.fromJson(json),
  Chat: (json) => Chat.fromJson(json),
  Authentication: (json) => Authentication.fromJson(json),
};

extension StringExt on Response {
  ApiResponse decodeApiResponse() =>
      ApiResponse.fromJson(jsonDecode(utf8.decode(bodyBytes)));

  Rejection asRejection() => Rejection('Response: $statusCode, $reasonPhrase');
}