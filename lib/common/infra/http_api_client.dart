import 'dart:io';

import 'package:askimam/common/domain/apiClient.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/common/web/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class HttpApiClient implements ApiClient {
  final Client _client;
  final String _url;

  const HttpApiClient(this._client, this._url);

  @override
  Future<Option<Rejection>> delete(String suffix) async {
    try {
      final url = Uri.parse('$_url/$suffix');
      final response = await _client.delete(url, headers: {
        HttpHeaders.acceptHeader: ContentType.json.value,
      });

      if (response.statusCode == 200) {
        final apiResponse = response.decodeApiResponse();

        if (apiResponse.status == ApiResponseStatus.Ok) {
          return none();
        } else {
          return some(apiResponse.toRejection());
        }
      } else {
        return some(
          Rejection('NOK: ${response.statusCode}, ${response.reasonPhrase}'),
        );
      }
    } catch (e) {
      return some(Rejection(e.toString()));
    }
  }

  @override
  Future<Either<Rejection, List<T>>> getList<T>(String suffix) {
    // TODO: implement getList
    throw UnimplementedError();
  }
}
