import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/infra/dto/update_fcm_token.dart';
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
          const LoginRequest('login', 'password', 'fcm'),
        ),
      ).thenAnswer(
        (_) async => right(
          const Authentication('jwt', 1, UserType.Inquirer, 'fcm'),
        ),
      );
      when(settings.saveAuthentication(
        const Authentication('jwt', 1, UserType.Inquirer, 'fcm'),
      )).thenAnswer((p) async => right(p.positionalArguments[0]));

      final result = await repo.login(
        const LoginRequest('login', 'password', 'fcm'),
      );

      expect(
        result,
        right(const Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      );

      verify(settings.saveAuthentication(
        const Authentication('jwt', 1, UserType.Inquirer, 'fcm'),
      )).called(1);
    });

    test('should not be ok', () async {
      when(
        api.postAndGetResponse<Authentication, LoginRequest>(
          'auth/login',
          const LoginRequest('login', 'password', 'fcm'),
        ),
      ).thenAnswer(
        (_) async => right(
          const Authentication('jwt', 1, UserType.Inquirer, 'fcm'),
        ),
      );
      when(settings.saveAuthentication(
        const Authentication('jwt', 1, UserType.Inquirer, 'fcm'),
      )).thenAnswer((p) async => left(Rejection('reason')));

      final result =
          await repo.login(const LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('reason')));
    });

    test('should be nok', () async {
      when(
        api.postAndGetResponse<Authentication, LoginRequest>(
          'auth/login',
          const LoginRequest('login', 'password', 'fcm'),
        ),
      ).thenAnswer((_) async => left(Rejection('reason')));

      final result =
          await repo.login(const LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('reason')));
    });
  });

  group('Logout:', () {
    test('should be ok', () async {
      when(settings.clearAuthentication()).thenAnswer((_) async => none());
      when(api.post('auth/logout', const LogoutRequest('fcmToken')))
          .thenAnswer((_) async => none());

      final result = await repo.logout(const LogoutRequest('fcmToken'));

      expect(result, none());

      verify(settings.clearAuthentication()).called(1);
    });

    test('should fail server request', () async {
      when(settings.clearAuthentication()).thenAnswer((_) async => none());
      when(api.post('auth/logout', const LogoutRequest('fcmToken')))
          .thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo.logout(const LogoutRequest('fcmToken'));

      expect(result, some(Rejection('reason')));
      verify(settings.clearAuthentication()).called(1);
    });

    test('should not be ok', () async {
      when(settings.clearAuthentication())
          .thenAnswer((_) async => some(Rejection('reason2')));

      final result = await repo.logout(const LogoutRequest('fcmToken'));

      expect(result, some(Rejection('reason2')));
    });
  });

  group('Load:', () {
    test('should be ok', () async {
      when(settings.loadAuthentication()).thenAnswer((_) async => right(
            const Authentication('jwt', 1, UserType.Imam, 'fcm'),
          ));

      final result = await repo.load();

      expect(
        result,
        right(const Authentication('jwt', 1, UserType.Imam, 'fcm')),
      );
    });

    test('should not be ok', () async {
      when(settings.loadAuthentication())
          .thenAnswer((_) async => left(Rejection('reason')));

      final result = await repo.load();

      expect(result, left(Rejection('reason')));
    });
  });

  group('Update fcm token:', () {
    test('should be ok', () async {
      when(
        api.patchWithBody(
          'user/update-fcm-token',
          const UpdateFcmToken('oldToken', 'newToken'),
        ),
      ).thenAnswer((_) async => none());

      final result = await repo
          .updateFcmToken(const UpdateFcmToken('oldToken', 'newToken'));

      expect(result, none());
    });

    test('should not be ok', () async {
      when(
        api.patchWithBody(
          'user/update-fcm-token',
          const UpdateFcmToken('oldToken', 'newToken'),
        ),
      ).thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo
          .updateFcmToken(const UpdateFcmToken('oldToken', 'newToken'));

      expect(result, some(Rejection('reason')));
    });
  });
}
