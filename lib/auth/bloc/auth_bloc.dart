import 'dart:async';

import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;
  final ApiClient _apiClient;
  final NotificationService _notificationService;

  AuthBloc(
    this._repo,
    this._apiClient,
    this._notificationService,
  ) : super(const _Unauthenticated()) {
    add(const AuthEvent.load());
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) => event.when(
        load: _load,
        login: _login,
        logout: _logout,
      );

  Stream<AuthState> _load() async* {
    yield const AuthState.inProgress();

    final result = await _repo.load();

    yield result.fold(
      (l) => AuthState.error(l),
      (r) {
        _apiClient.setJwt(r.jwt);
        return AuthState.authenticated(r);
      },
    );
  }

  Stream<AuthState> _login(String login, String password) async* {
    yield const AuthState.inProgress();

    final result = await _notificationService.getFcmToken();

    yield* result.fold(
      (l) async* {
        yield AuthState.error(l);
      },
      (r) async* {
        final result = await _repo.login(LoginRequest(login, password, r));

        yield result.fold(
          (l) => AuthState.error(l),
          (r) {
            _apiClient.setJwt(r.jwt);
            return AuthState.authenticated(r);
          },
        );
      },
    );
  }

  Stream<AuthState> _logout() async* {
    yield const AuthState.inProgress();

    final result = await _notificationService.getFcmToken();

    yield* result.fold(
      (l) async* {
        yield AuthState.error(l);
      },
      (r) async* {
        final result = await _repo.logout(LogoutRequest(r));

        yield result.fold(
          () {
            _apiClient.resetJwt();
            return const AuthState.unauthenticated();
          },
          (l) => AuthState.error(l),
        );
      },
    );
  }
}
