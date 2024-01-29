import 'dart:async';

import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/auth/infra/dto/update_fcm_token.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:askimam/common/domain/service/settings.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repo;
  final ApiClient _apiClient;
  final Settings _settings;
  final NotificationService _notificationService;

  late final StreamSubscription _tokenRefreshesSubscription;

  AuthBloc(
    this._repo,
    this._apiClient,
    this._settings,
    this._notificationService,
  ) : super(const AuthStateUnauthenticated()) {
    _tokenRefreshesSubscription = _notificationService
        .tokenRefreshes()
        .listen((token) => add(AuthEventUpdateFcmToken(token)));

    on<AuthEventLoad>((event, emit) async {
      emit(const AuthStateInProgress());

      final result = await _repo.load();

      emit(result.fold(
        (l) => AuthStateError(l),
        (r) {
          _apiClient.setJwt(r.jwt);
          return AuthStateAuthenticated(r);
        },
      ));
    });

    on<AuthEventLogin>((event, emit) async {
      emit(const AuthStateInProgress());

      final result = await _notificationService.getFcmToken();

      await result.fold(
        (l) async => emit(AuthStateError(l)),
        (r) async {
          final result = await _repo.login(LoginRequest(
            event.login,
            event.password,
            r,
          ));

          result.fold(
            (l) => emit(AuthStateError(l)),
            (r) {
              _apiClient.setJwt(r.jwt);
              emit(AuthStateAuthenticated(r));
            },
          );
        },
      );
    });

    on<AuthEventLogout>((event, emit) async {
      emit(const AuthStateInProgress());

      final result = await _notificationService.getFcmToken();

      await result.fold(
        (l) async => emit(AuthStateError(l)),
        (r) async {
          _apiClient.resetJwt();

          final result = await _repo.logout(LogoutRequest(r));

          emit(result.fold(
            () => const AuthStateUnauthenticated(),
            (l) => AuthStateError(l),
          ));
        },
      );
    });

    on<AuthEventUpdateFcmToken>((event, emit) async {
      if (state is AuthStateAuthenticated) {
        final authenticatedState = state as AuthStateAuthenticated;
        final oldToken = authenticatedState.authentication.fcmToken;

        if (oldToken != event.newToken) {
          final result = await _repo.updateFcmToken(
            UpdateFcmToken(oldToken, event.newToken),
          );

          await result.fold(
            () async {
              final authentication = Authentication(
                authenticatedState.authentication.jwt,
                authenticatedState.authentication.userId,
                authenticatedState.authentication.userType,
                event.newToken,
              );
              final settingsResult =
                  await _settings.saveAuthentication(authentication);

              settingsResult.fold(
                (l) => emit(AuthStateError(l)),
                (r) => emit(AuthStateAuthenticated(r)),
              );
            },
            (a) async => emit(AuthStateError(a)),
          );
        }
      }
    });
  }

  @override
  Future<void> close() {
    _tokenRefreshesSubscription.cancel();
    return super.close();
  }
}
