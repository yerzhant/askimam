import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/authentication_request.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_bloc_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  late AuthBloc bloc;
  final repo = MockAuthRepository();

  setUp(() {
    bloc = AuthBloc(repo);
  });

  test('Initial state', () {
    expect(bloc.state, const AuthState.unauthenticated());
  });

  group('Login:', () {
    blocTest(
      'should login',
      build: () {
        when(repo.login(AuthenticationRequest('login', 'password'))).thenAnswer(
            (_) async => right(Authentication('123', UserType.Inquirer)));

        return bloc;
      },
      act: (_) =>
          bloc.add(AuthEvent.login(AuthenticationRequest('login', 'password'))),
      expect: () => [
        const AuthState.inProgress(),
        AuthState.authenticated(Authentication('123', UserType.Inquirer)),
      ],
    );

    blocTest(
      'should not login',
      build: () {
        when(repo.login(AuthenticationRequest('login', 'password')))
            .thenAnswer((_) async => left(Rejection('reason')));

        return bloc;
      },
      act: (_) =>
          bloc.add(AuthEvent.login(AuthenticationRequest('login', 'password'))),
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
        when(repo.logout()).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () =>
          AuthState.authenticated(Authentication('jwt', UserType.Inquirer)),
      act: (_) => bloc.add(const AuthEvent.logout()),
      expect: () => [
        const AuthState.inProgress(),
        const AuthState.unauthenticated(),
      ],
    );

    blocTest(
      'should not logout',
      build: () {
        when(repo.logout()).thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () =>
          AuthState.authenticated(Authentication('jwt', UserType.Inquirer)),
      act: (_) => bloc.add(const AuthEvent.logout()),
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );
  });

  group('Init from a local storage:', () {
    blocTest(
      'should get an authentication',
      build: () {
        when(repo.load()).thenAnswer(
            (_) async => right(Authentication('jwt', UserType.Inquirer)));
        return bloc;
      },
      act: (_) => bloc.add(const AuthEvent.load()),
      expect: () => [
        const AuthState.inProgress(),
        AuthState.authenticated(Authentication('jwt', UserType.Inquirer)),
      ],
    );

    blocTest(
      'should not load an authentication',
      build: () {
        when(repo.load()).thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const AuthEvent.load()),
      expect: () => [
        const AuthState.inProgress(),
        AuthState.error(Rejection('reason')),
      ],
    );
  });
}
