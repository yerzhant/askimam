import 'dart:io';

import 'package:askimam/common/domain/apiClient.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/common/web/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class HttpApiClient implements ApiClient {
  final Client _client;
  final String _url;
  final String _jwt;

  const HttpApiClient(this._client, this._url, this._jwt);

  @override
  Future<Option<Rejection>> delete(String suffix) async {
    try {
      final response = await _client.delete(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final apiResponse = response.decodeApiResponse();

        if (apiResponse.status == ApiResponseStatus.Ok) {
          return none();
        } else {
          return some(apiResponse.asRejection());
        }
      } else {
        return some(response.asRejection());
      }
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Either<Rejection, List<T>>> getList<T>(String suffix) async {
    try {
      final response = await _client.get(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      if (response.statusCode == 200) {
        final apiResponse = response.decodeApiResponse();

        if (apiResponse.status == ApiResponseStatus.Ok) {
          return right(apiResponse.list<T>());
          // } else {
          //   return some(apiResponse.asRejection());
        }
      } else {
        // return some(
        //   Rejection('NOK: ${response.statusCode}, ${response.reasonPhrase}'),
        // );
      }
      return left(Rejection('reason'));
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  Uri _constructUrl(String suffix) {
    final url = Uri.parse('$_url/$suffix');
    return url;
  }

  Map<String, String> _getHeaders() => {
        HttpHeaders.acceptHeader: ContentType.json.value,
        if (_jwt.trim().isNotEmpty)
          HttpHeaders.authorizationHeader: 'Bearer $_jwt',
      };
}
