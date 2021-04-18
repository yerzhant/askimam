import 'package:askimam/auth/domain/auth_repository.dart';
import 'package:askimam/common/domain/api_client.dart';
import 'package:askimam/common/domain/settings.dart';
import 'package:askimam/common/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/auth/domain/authentication_request.dart';
import 'package:askimam/auth/domain/authentication.dart';

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
