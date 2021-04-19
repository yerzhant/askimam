import 'dart:async';
import 'dart:io';

import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/infra/dto/api_response.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';

class HttpApiClient implements ApiClient {
  final Client _client;
  final AuthBloc authBloc;
  final String _url;
  String _jwt = '';
  late StreamSubscription subscription;

  HttpApiClient(this._client, this.authBloc, this._url) {
    subscription = authBloc.stream.listen((state) {
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

      if (httpResponse.statusCode == 200) {
        final response = httpResponse.decodeApiResponse();

        if (response.status == ApiResponseStatus.Ok) {
          return right(response.value<M>());
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

  @override
  Future<Option<Rejection>> patch(String suffix) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<Option<Rejection>> patchWithBody<M extends Model>(
      String suffix, M model) {
    // TODO: implement patchWithBody
    throw UnimplementedError();
  }

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

  Uri _constructUrl(String suffix) => Uri.parse('$_url/$suffix');

  Map<String, String> _getHeaders() => {
        HttpHeaders.acceptHeader: ContentType.json.value,
        if (_jwt.isNotEmpty) HttpHeaders.authorizationHeader: 'Bearer $_jwt',
      };
}
