part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthStateInProgress extends AuthState {
  const AuthStateInProgress();
}

final class AuthStateError extends AuthState {
  final Rejection rejection;

  const AuthStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}

final class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();
}

final class AuthStateAuthenticated extends AuthState {
  final Authentication authentication;

  const AuthStateAuthenticated(this.authentication);

  @override
  List<Object?> get props => [authentication];
}
