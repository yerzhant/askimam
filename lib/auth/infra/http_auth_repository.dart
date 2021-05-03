import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/settings.dart';
import 'package:dartz/dartz.dart';

const _url = 'auth';

class HttpAuthRepository implements AuthRepository {
  final ApiClient _api;
  final Settings _settings;

  const HttpAuthRepository(this._api, this._settings);

  @override
  Future<Either<Rejection, Authentication>> load() =>
      _settings.loadAuthentication();

  @override
  Future<Either<Rejection, Authentication>> login(LoginRequest request) async {
    final result = await _api.postAndGetResponse<Authentication, LoginRequest>(
        '$_url/login', request);

    return result.fold(
      (l) => left(l),
      (r) => _settings.saveAuthentication(r),
    );
  }

  @override
  Future<Option<Rejection>> logout(LogoutRequest request) async {
    final result = await _api.post('$_url/logout', request);

    return result.fold(
      () => _settings.clearAuthentication(),
      (a) => some(a),
    );
  }
}
