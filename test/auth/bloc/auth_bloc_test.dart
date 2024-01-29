import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/infra/dto/update_fcm_token.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:askimam/common/domain/service/settings.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, ApiClient, Settings, NotificationService])
void main() {
  late AuthBloc bloc;
  late ApiClient apiClient;
  late MockSettings settings;
  late MockAuthRepository repo;
  late NotificationService notificationService;

  setUp(() {
    settings = MockSettings();
    apiClient = MockApiClient();
    repo = MockAuthRepository();
    notificationService = MockNotificationService();

    when(repo.load()).thenAnswer((_) async =>
        right(const Authentication('jwt', 1, UserType.Inquirer, 'fcm')));
    when(notificationService.getFcmToken())
        .thenAnswer((_) async => right('fcm'));
    when(notificationService.tokenRefreshes())
        .thenAnswer((_) => const Stream.empty());

    bloc = AuthBloc(repo, apiClient, settings, notificationService);
  });

  test('Initial state', () {
    expect(bloc.state, const AuthStateUnauthenticated());
  });

  group('Login:', () {
    blocTest<AuthBloc, AuthState>(
      'should login',
      build: () {
        when(repo.login(const LoginRequest('login', 'password', 'fcm')))
            .thenAnswer((_) async => right(
                const Authentication('123', 1, UserType.Inquirer, 'fcm')));
        return bloc;
      },
      seed: () => const AuthStateUnauthenticated(),
      act: (_) => bloc.add(const AuthEventLogin('login', 'password')),
      expect: () => [
        const AuthStateInProgress(),
        const AuthStateAuthenticated(
            Authentication('123', 1, UserType.Inquirer, 'fcm')),
      ],
      verify: (_) => verify(apiClient.setJwt('123')).called(1),
    );

    blocTest<AuthBloc, AuthState>(
      'should fail getting an fcm token',
      build: () {
        when(notificationService.getFcmToken())
            .thenAnswer((_) async => left(Rejection('reason')));

        return bloc;
      },
      seed: () => const AuthStateUnauthenticated(),
      act: (_) => bloc.add(const AuthEventLogin('login', 'password')),
      expect: () => [
        const AuthStateInProgress(),
        AuthStateError(Rejection('reason')),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should not login',
      build: () {
        when(repo.login(const LoginRequest('login', 'password', 'fcm')))
            .thenAnswer((_) async => left(Rejection('reason')));

        return bloc;
      },
      seed: () => const AuthStateUnauthenticated(),
      act: (_) => bloc.add(const AuthEventLogin('login', 'password')),
      expect: () => [
        const AuthStateInProgress(),
        AuthStateError(Rejection('reason')),
      ],
    );
  });

  group('Logout:', () {
    blocTest<AuthBloc, AuthState>(
      'should logout',
      build: () {
        when(repo.logout(const LogoutRequest('fcm')))
            .thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventLogout()),
      expect: () => [
        const AuthStateInProgress(),
        const AuthStateUnauthenticated(),
      ],
      verify: (_) => verify(apiClient.resetJwt()).called(1),
    );

    blocTest<AuthBloc, AuthState>(
      'should not logout',
      build: () {
        when(repo.logout(const LogoutRequest('fcm')))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventLogout()),
      expect: () => [
        const AuthStateInProgress(),
        AuthStateError(Rejection('reason')),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'should fail to get an fcm token',
      build: () {
        when(notificationService.getFcmToken())
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventLogout()),
      expect: () => [
        const AuthStateInProgress(),
        AuthStateError(Rejection('reason')),
      ],
    );
  });

  group('Init from a local storage:', () {
    blocTest(
      'should get an authentication',
      build: () => bloc,
      act: (_) => bloc.add(const AuthEventLoad()),
      expect: () => [
        const AuthStateInProgress(),
        const AuthStateAuthenticated(
            Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      ],
      verify: (_) => verify(apiClient.setJwt('jwt')).called(1),
    );

    blocTest(
      'should not load an authentication',
      build: () {
        when(repo.load()).thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const AuthEventLoad()),
      expect: () => [
        const AuthStateInProgress(),
        AuthStateError(Rejection('reason')),
      ],
    );
  });

  group('Update fcm token:', () {
    blocTest<AuthBloc, AuthState>(
      'should do nothing',
      build: () => bloc,
      seed: () => const AuthStateUnauthenticated(),
      act: (_) => bloc.add(const AuthEventUpdateFcmToken('fcm1')),
      expect: () => [],
      verify: (_) => verifyNever(repo.updateFcmToken(any)),
    );

    blocTest<AuthBloc, AuthState>(
      'should do nothing either',
      build: () => bloc,
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventUpdateFcmToken('fcm')),
      expect: () => [],
      verify: (_) => verifyNever(repo.updateFcmToken(any)),
    );

    blocTest<AuthBloc, AuthState>(
      'api update failed',
      build: () {
        when(repo.updateFcmToken(any))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventUpdateFcmToken('fcm1')),
      expect: () => [AuthStateError(Rejection('reason'))],
      verify: (_) {
        verify(repo.updateFcmToken(const UpdateFcmToken('fcm', 'fcm1')))
            .called(1);
        verifyNever(settings.saveAuthentication(
          const Authentication('jwt', 1, UserType.Inquirer, 'fcm1'),
        ));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'save authentication failed',
      build: () {
        when(settings.saveAuthentication(any))
            .thenAnswer((i) async => left(Rejection('reason')));
        when(repo.updateFcmToken(any)).thenAnswer((_) async => none());

        return bloc;
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventUpdateFcmToken('fcm1')),
      expect: () => [AuthStateError(Rejection('reason'))],
      verify: (_) {
        verify(repo.updateFcmToken(const UpdateFcmToken('fcm', 'fcm1')))
            .called(1);
        verify(settings.saveAuthentication(
          const Authentication('jwt', 1, UserType.Inquirer, 'fcm1'),
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should update a token',
      build: () {
        when(settings.saveAuthentication(any))
            .thenAnswer((i) async => right(i.positionalArguments[0]));
        when(repo.updateFcmToken(any)).thenAnswer((_) async => none());

        return bloc;
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      act: (_) => bloc.add(const AuthEventUpdateFcmToken('fcm1')),
      expect: () => [
        const AuthStateAuthenticated(
            Authentication('jwt', 1, UserType.Inquirer, 'fcm1')),
      ],
      verify: (_) {
        verify(repo.updateFcmToken(const UpdateFcmToken('fcm', 'fcm1')))
            .called(1);
        verify(settings.saveAuthentication(
          const Authentication('jwt', 1, UserType.Inquirer, 'fcm1'),
        )).called(1);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should update a token from stream',
      build: () {
        when(settings.saveAuthentication(any))
            .thenAnswer((i) async => right(i.positionalArguments[0]));
        when(repo.updateFcmToken(any)).thenAnswer((_) async => none());
        when(notificationService.tokenRefreshes())
            .thenAnswer((_) => Stream.fromIterable(['fcm1']));

        return AuthBloc(repo, apiClient, settings, notificationService);
      },
      seed: () => const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm')),
      expect: () => [
        const AuthStateAuthenticated(
          Authentication('jwt', 1, UserType.Inquirer, 'fcm1'),
        ),
      ],
      verify: (_) {
        verify(repo.updateFcmToken(const UpdateFcmToken('fcm', 'fcm1')))
            .called(1);
        verify(settings.saveAuthentication(
          const Authentication('jwt', 1, UserType.Inquirer, 'fcm1'),
        )).called(1);
      },
    );
  });
}
