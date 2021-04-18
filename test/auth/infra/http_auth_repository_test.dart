import 'package:askimam/auth/domain/authentication.dart';
import 'package:askimam/auth/domain/authentication_request.dart';
import 'package:askimam/auth/infra/http_auth_repository.dart';
import 'package:askimam/common/domain/api_client.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/common/domain/settings.dart';
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
        api.postAndGetResponse<Authentication, AuthenticationRequest>(
          'authenticate',
          AuthenticationRequest('login', 'password'),
        ),
      ).thenAnswer(
        (_) async => right(Authentication('jwt', UserType.Inquirer)),
      );
      when(settings.setAuthentication(Authentication('jwt', UserType.Inquirer)))
          .thenAnswer((p) async => right(p.positionalArguments[0]));

      final result =
          await repo.login(AuthenticationRequest('login', 'password'));

      expect(result, right(Authentication('jwt', UserType.Inquirer)));

      verify(
        settings.setAuthentication(Authentication('jwt', UserType.Inquirer)),
      ).called(1);
    });

    test('should not be ok', () async {
      when(
        api.postAndGetResponse<Authentication, AuthenticationRequest>(
          'authenticate',
          AuthenticationRequest('login', 'password'),
        ),
      ).thenAnswer(
        (_) async => right(Authentication('jwt', UserType.Inquirer)),
      );
      when(settings.setAuthentication(Authentication('jwt', UserType.Inquirer)))
          .thenAnswer((p) async => left(Rejection('reason')));

      final result =
          await repo.login(AuthenticationRequest('login', 'password'));

      expect(result, left(Rejection('reason')));
    });

    test('should be nok', () async {
      when(
        api.postAndGetResponse<Authentication, AuthenticationRequest>(
          'authenticate',
          AuthenticationRequest('login', 'password'),
        ),
      ).thenAnswer((_) async => left(Rejection('reason')));

      final result =
          await repo.login(AuthenticationRequest('login', 'password'));

      expect(result, left(Rejection('reason')));
    });
  });

  group('Logout:', () {
    test('should be ok', () async {
      when(settings.clearAuthentication()).thenAnswer((_) async => none());

      final result = await repo.logout();

      expect(result, none());

      verify(settings.clearAuthentication()).called(1);
    });

    test('should not be ok', () async {
      when(settings.clearAuthentication())
          .thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo.logout();

      expect(result, some(Rejection('reason')));
    });
  });

  group('Load:', () {
    test('should be ok', () async {
      when(settings.getAuthentication())
          .thenAnswer((_) async => right(Authentication('jwt', UserType.Imam)));

      final result = await repo.load();

      expect(result, right(Authentication('jwt', UserType.Imam)));
    });

    test('should not be ok', () async {
      when(settings.getAuthentication())
          .thenAnswer((_) async => left(Rejection('reason')));

      final result = await repo.load();

      expect(result, left(Rejection('reason')));
    });
  });
}
