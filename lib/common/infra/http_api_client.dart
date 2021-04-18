import 'dart:io';

import 'package:askimam/common/domain/api_client.dart';
import 'package:askimam/common/domain/model.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/common/web/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class HttpApiClient implements ApiClient {
  final Client _client;
  final String _url;
  final String jwt;

  const HttpApiClient(this._client, this._url, {this.jwt = ''});

  @override
  Future<Option<Rejection>> delete(String suffix) async {
    try {
      final httpResponse = await _client.delete(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      if (httpResponse.statusCode == 200) {
        final response = httpResponse.decodeApiResponse();

        if (response.status == ApiResponseStatus.Ok) {
          return none();
        } else {
          return some(response.asRejection());
        }
      } else {
        return some(httpResponse.asRejection());
      }
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Either<Rejection, List<T>>> getList<T extends Model>(
    String suffix,
  ) async {
    try {
      final httpResponse = await _client.get(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      if (httpResponse.statusCode == 200) {
        final response = httpResponse.decodeApiResponse();

        if (response.status == ApiResponseStatus.Ok) {
          return right(response.list<T>());
        } else {
          return left(response.asRejection());
        }
      } else {
        return left(httpResponse.asRejection());
      }
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  Uri _constructUrl(String suffix) => Uri.parse('$_url/$suffix');

  Map<String, String> _getHeaders() => {
        HttpHeaders.acceptHeader: ContentType.json.value,
        if (jwt.trim().isNotEmpty)
          HttpHeaders.authorizationHeader: 'Bearer $jwt',
      };

  @override
  Future<Option<Rejection>> post<M extends Model>(String suffix, M model) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<Either<Rejection, R>>
      postAndGetResponse<R extends Model, M extends Model>(
          String suffix, M model) {
    // TODO: implement postAndGetResponse
    throw UnimplementedError();
  }
}
