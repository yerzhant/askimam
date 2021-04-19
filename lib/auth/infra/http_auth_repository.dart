import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/authentication_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/settings.dart';
import 'package:dartz/dartz.dart';

const _url = 'authenticate';

class HttpAuthRepository implements AuthRepository {
  final ApiClient _api;
  final Settings _settings;

  const HttpAuthRepository(this._api, this._settings);

  @override
  Future<Either<Rejection, Authentication>> load() =>
      _settings.getAuthentication();

  @override
  Future<Either<Rejection, Authentication>> login(
      AuthenticationRequest request) async {
    final result =
        await _api.postAndGetResponse<Authentication, AuthenticationRequest>(
            _url, request);

    return result.fold(
      (l) => left(l),
      (r) => _settings.setAuthentication(r),
    );
  }

  @override
  Future<Option<Rejection>> logout() => _settings.clearAuthentication();
}
