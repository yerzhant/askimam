part of 'public_chats_bloc.dart';

sealed class PublicChatsState extends Equatable {
  const PublicChatsState();

  @override
  List<Object?> get props => [];
}

final class PublicChatsStateSuccess extends PublicChatsState {
  final List<Chat> chats;

  const PublicChatsStateSuccess(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class PublicChatsStateInProgress extends PublicChatsState {
  final List<Chat> chats;

  const PublicChatsStateInProgress(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class PublicChatsStateError extends PublicChatsState {
  final Rejection rejection;

  const PublicChatsStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
