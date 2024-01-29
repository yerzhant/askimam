part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

final class AuthEventLoad extends AuthEvent {
  const AuthEventLoad();
}

final class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();
}

final class AuthEventLogin extends AuthEvent {
  final String login;
  final String password;

  const AuthEventLogin(this.login, this.password);

  @override
  List<Object?> get props => [login, password];
}

final class AuthEventUpdateFcmToken extends AuthEvent {
  final String newToken;

  const AuthEventUpdateFcmToken(this.newToken);

  @override
  List<Object?> get props => [newToken];
}
