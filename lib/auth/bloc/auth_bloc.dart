import 'dart:async';

import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/authentication_request.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;

  AuthBloc(this._repo) : super(const _Unauthenticated()) {
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
      (r) => AuthState.authenticated(r),
    );
  }

  Stream<AuthState> _login(AuthenticationRequest request) async* {
    yield const AuthState.inProgress();

    final result = await _repo.login(request);

    yield result.fold(
      (l) => AuthState.error(l),
      (r) => AuthState.authenticated(r),
    );
  }

  Stream<AuthState> _logout() async* {
    yield const AuthState.inProgress();

    final result = await _repo.logout();

    yield result.fold(
      () => const AuthState.unauthenticated(),
      (l) => AuthState.error(l),
    );
  }
}
