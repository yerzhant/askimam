import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/infra/http_auth_repository.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/settings.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_auth_repository_test.mocks.dart';

@GenerateMocks([ApiClient, Settings])
void main() {
  final api = MockApiClient();
  final settings = MockSettings();
  final repo = HttpAuthRepository(api, settings);

  group('Login:', () {
    test('should be ok', () async {
      when(
        api.postAndGetResponse<Authentication, LoginRequest>(
          'auth/login',
          LoginRequest('login', 'password', 'fcm'),
        ),
      ).thenAnswer(
        (_) async => right(Authentication('jwt', 1, UserType.Inquirer)),
      );
      when(settings.saveAuthentication(
        Authentication('jwt', 1, UserType.Inquirer),
      )).thenAnswer((p) async => right(p.positionalArguments[0]));

      final result = await repo.login(LoginRequest('login', 'password', 'fcm'));

      expect(result, right(Authentication('jwt', 1, UserType.Inquirer)));

      verify(settings.saveAuthentication(
        Authentication('jwt', 1, UserType.Inquirer),
      )).called(1);
    });

    test('should not be ok', () async {
      when(
        api.postAndGetResponse<Authentication, LoginRequest>(
          'auth/login',
          LoginRequest('login', 'password', 'fcm'),
        ),
      ).thenAnswer(
        (_) async => right(Authentication('jwt', 1, UserType.Inquirer)),
      );
      when(settings.saveAuthentication(
        Authentication('jwt', 1, UserType.Inquirer),
      )).thenAnswer((p) async => left(Rejection('reason')));

      final result = await repo.login(LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('reason')));
    });

    test('should be nok', () async {
      when(
        api.postAndGetResponse<Authentication, LoginRequest>(
          'auth/login',
          LoginRequest('login', 'password', 'fcm'),
        ),
      ).thenAnswer((_) async => left(Rejection('reason')));

      final result = await repo.login(LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('reason')));
    });
  });

  group('Logout:', () {
    test('should be ok', () async {
      when(settings.clearAuthentication()).thenAnswer((_) async => none());
      when(api.post('auth/logout', LogoutRequest('fcmToken')))
          .thenAnswer((_) async => none());

      final result = await repo.logout(LogoutRequest('fcmToken'));

      expect(result, none());

      verify(settings.clearAuthentication()).called(1);
    });

    test('should fail server request', () async {
      when(settings.clearAuthentication()).thenAnswer((_) async => none());
      when(api.post('auth/logout', LogoutRequest('fcmToken')))
          .thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo.logout(LogoutRequest('fcmToken'));

      expect(result, some(Rejection('reason')));
      verify(settings.clearAuthentication()).called(1);
    });

    test('should not be ok', () async {
      when(settings.clearAuthentication())
          .thenAnswer((_) async => some(Rejection('reason2')));

      final result = await repo.logout(LogoutRequest('fcmToken'));

      expect(result, some(Rejection('reason2')));
    });
  });

  group('Load:', () {
    test('should be ok', () async {
      when(settings.loadAuthentication()).thenAnswer(
          (_) async => right(Authentication('jwt', 1, UserType.Imam)));

      final result = await repo.load();

      expect(result, right(Authentication('jwt', 1, UserType.Imam)));
    });

    test('should not be ok', () async {
      when(settings.loadAuthentication())
          .thenAnswer((_) async => left(Rejection('reason')));

      final result = await repo.load();

      expect(result, left(Rejection('reason')));
    });
  });
}
