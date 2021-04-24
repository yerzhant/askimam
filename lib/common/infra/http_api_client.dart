import 'dart:async';
import 'dart:io';

import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/infra/dto/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart';

class HttpApiClient implements ApiClient, Disposable {
  final Client _client;
  final AuthBloc _authBloc;
  final String _url;
  String _jwt = '';
  late StreamSubscription _subscription;

  HttpApiClient(this._client, this._authBloc, this._url) {
    _subscription = _authBloc.stream.listen((state) {
      state.maybeWhen(
        authenticated: (auth) {
          _jwt = auth.jwt;
        },
        orElse: () {
          _jwt = '';
        },
      );
    });
  }

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

  Uri _constructUrl(String suffix) => Uri.parse('$_url/$suffix');

  Map<String, String> _getHeaders() => {
        HttpHeaders.acceptHeader: ContentType.json.value,
        if (_jwt.isNotEmpty) HttpHeaders.authorizationHeader: 'Bearer $_jwt',
      };

  @override
  Future<void> dispose() async => _subscription.cancel();
}
