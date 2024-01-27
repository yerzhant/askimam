import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/auth/domain/model/logout_request.dart';
import 'package:askimam/auth/domain/repo/auth_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
  ) : super(const AuthStateUnauthenticated()) {
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
  }
}
