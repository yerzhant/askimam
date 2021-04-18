part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.inProgress() = _InProgress;
  const factory AuthState.error(Rejection rejection) = _Error;
  const factory AuthState.authenticated(Authentication authentication) =
      _Authenticated;
}
