part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.load() = _Load;
  const factory AuthEvent.logout() = _Logout;
  const factory AuthEvent.login(String login, String password) = _Login;
}
