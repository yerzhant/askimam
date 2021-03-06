import 'dart:async';
import 'dart:io';

import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/infra/dto/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class HttpApiClient implements ApiClient {
  final Client _client;
  final String _url;
  String _jwt = '';

  HttpApiClient(this._client, this._url);

  @override
  Future<Either<Rejection, M>> get<M extends Model>(String suffix) async {
    try {
      final httpResponse = await _client.get(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      return _processHttpResponse(
        httpResponse,
        (response) => right(response.value()),
        (rejection) => left(rejection),
      );
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  @override
  Future<Either<Rejection, List<M>>> getList<M extends Model>(
    String suffix,
  ) async {
    try {
      final httpResponse = await _client.get(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      return _processHttpResponse(
        httpResponse,
        (response) => right(response.list()),
        (rejection) => left(rejection),
      );
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  @override
  Future<Option<Rejection>> post<M extends Model>(
      String suffix, M model) async {
    try {
      final httpResponse = await _client.post(
        _constructUrl(suffix),
        headers: _getHeaders(),
        body: model.toJsonUtf8(),
      );

      return _processHttpResponse(
        httpResponse,
        (_) => none(),
        (rejection) => some(rejection),
      );
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Either<Rejection, R>>
      postAndGetResponse<R extends Model, M extends Model>(
          String suffix, M model) async {
    try {
      final httpResponse = await _client.post(
        _constructUrl(suffix),
        headers: _getHeaders(),
        body: model.toJsonUtf8(),
      );

      return _processHttpResponse(
        httpResponse,
        (r) => right(r.value()),
        (rejection) => left(rejection),
      );
    } on Exception catch (e) {
      return left(e.asRejection());
    }
  }

  @override
  Future<Option<Rejection>> patch(String suffix) async {
    try {
      final httpResponse = await _client.patch(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      return _processHttpResponse(
        httpResponse,
        (_) => none(),
        (rejection) => some(rejection),
      );
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Option<Rejection>> patchWithBody<M extends Model>(
      String suffix, M model) async {
    try {
      final httpResponse = await _client.patch(
        _constructUrl(suffix),
        headers: _getHeaders(),
        body: model.toJsonUtf8(),
      );

      return _processHttpResponse(
        httpResponse,
        (_) => none(),
        (rejection) => some(rejection),
      );
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Option<Rejection>> delete(String suffix) async {
    try {
      final httpResponse = await _client.delete(
        _constructUrl(suffix),
        headers: _getHeaders(),
      );

      return _processHttpResponse(
        httpResponse,
        (_) => none(),
        (rejection) => some(rejection),
      );
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  @override
  Future<Option<Rejection>> uploadFile(String suffix, File file) async {
    try {
      final request = MultipartRequest('POST', _constructUrl(suffix))
        ..headers[HttpHeaders.authorizationHeader] = 'Bearer $_jwt'
        ..files.add(MultipartFile.fromBytes(
          'file',
          file.readAsBytesSync(),
          filename: file.path.split('/').last,
        ));

      final streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        final response = await streamedResponse.decodeApiResponse();

        if (response.status == ApiResponseStatus.Ok) {
          return none();
        } else {
          return some(response.asRejection());
        }
      } else if (streamedResponse.statusCode == 401) {
        return some(Rejection('Unauthorized.'));
      } else {
        return some(streamedResponse.asRejection());
      }
    } on Exception catch (e) {
      return some(e.asRejection());
    }
  }

  T _processHttpResponse<T>(
    Response httpResponse,
    T Function(ApiResponse response) ok,
    T Function(Rejection rejection) nok,
  ) {
    if (httpResponse.statusCode == 200) {
      final response = httpResponse.decodeApiResponse();

      if (response.status == ApiResponseStatus.Ok) {
        return ok(response);
      } else {
        return nok(response.asRejection());
      }
    } else if (httpResponse.statusCode == 401) {
      return nok(Rejection('Unauthorized.'));
    } else {
      return nok(httpResponse.asRejection());
    }
  }

  @override
  void setJwt(String jwt) => _jwt = jwt;

  @override
  void resetJwt() => _jwt = '';

  Uri _constructUrl(String suffix) => Uri.parse('$_url/$suffix');

  Map<String, String> _getHeaders() => {
        HttpHeaders.acceptHeader: ContentType.json.value,
        HttpHeaders.contentTypeHeader: ContentType.json.value,
        if (_jwt.isNotEmpty) HttpHeaders.authorizationHeader: 'Bearer $_jwt',
      };
}
