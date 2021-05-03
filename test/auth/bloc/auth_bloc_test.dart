import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository, ApiClient, NotificationService])
void main() {
  late AuthBloc bloc;
  late ApiClient apiClient;
  final repo = MockAuthRepository();
  final notificationService = MockNotificationService();

  setUp(() {
    when(repo.load()).thenAnswer(
        (_) async => right(Authentication('jwt', 1, UserType.Inquirer)));
    when(notificationService.getFcmToken())
        .thenAnswer((_) async => right('fcm'));
    apiClient = MockApiClient();
    bloc = AuthBloc(repo, apiClient, notificationService);
  });

  test('Initial state', () {
    expect(bloc.state, const AuthState.unauthenticated());
  });

  group('Login:', () {
    blocTest(
      'should login',
      build: () {
        when(repo.login(LoginRequest('login', 'password', 'fcm'))).thenAnswer(
            (_) async => right(Authentication('123', 1, UserType.Inquirer)));
        return bloc;
      },
      seed: () => const AuthState.unauthenticated(),
      act: (_) => bloc.add(const AuthEvent.login('login', 'password')),
      skip: 2,
      expect: () => [
        const AuthState.inProgress(),
        AuthState.authenticated(Authentication('123', 1, UserType.Inquirer)),
      ],
      verify: (_) => verify(apiClient.setJwt('123')).called(1),
    );

    blocTest(
      'should fail getting an fcm token',
      build: () {
        when(notificationService.getFcmToken())
            .thenAnswer((_) async => left(Rejection('reason')));

        return bloc;
      },
      seed: () => const AuthState.unauthenticated(),
      act: (_) => bloc.add(const AuthEvent.login('login', 'password')),
      skip: 2,
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should not login',
      build: () {
        when(repo.login(LoginRequest('login', 'password', 'fcm')))
            .thenAnswer((_) async => left(Rejection('reason')));

        return bloc;
      },
      seed: () => const AuthState.unauthenticated(),
      act: (_) => bloc.add(const AuthEvent.login('login', 'password')),
      skip: 2,
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );
  });

  group('Logout:', () {
    blocTest(
      'should logout',
      build: () {
        when(repo.logout(LogoutRequest('fcm'))).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () =>
          AuthState.authenticated(Authentication('jwt', 1, UserType.Inquirer)),
      act: (_) => bloc.add(const AuthEvent.logout()),
      skip: 2,
      expect: () => [
        const AuthState.inProgress(),
        const AuthState.unauthenticated(),
      ],
      verify: (_) => verify(apiClient.resetJwt()).called(1),
    );

    blocTest(
      'should not logout',
      build: () {
        when(repo.logout(LogoutRequest('fcm')))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () =>
          AuthState.authenticated(Authentication('jwt', 1, UserType.Inquirer)),
      act: (_) => bloc.add(const AuthEvent.logout()),
      skip: 2,
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should fail to get an fcm token',
      build: () {
        when(notificationService.getFcmToken())
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () =>
          AuthState.authenticated(Authentication('jwt', 1, UserType.Inquirer)),
      act: (_) => bloc.add(const AuthEvent.logout()),
      skip: 2,
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );
  });

  group('Init from a local storage:', () {
    blocTest(
      'should get an authentication',
      build: () => bloc,
      expect: () => [
        const AuthState.inProgress(),
        AuthState.authenticated(Authentication('jwt', 1, UserType.Inquirer)),
      ],
      verify: (_) => verify(apiClient.setJwt('jwt')).called(1),
    );

    blocTest(
      'should not load an authentication',
      build: () {
        when(repo.load()).thenAnswer((_) async => left(Rejection('reason')));
        return AuthBloc(repo, apiClient, notificationService);
      },
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );
  });
}
