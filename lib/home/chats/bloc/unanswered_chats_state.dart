part of 'unanswered_chats_bloc.dart';

sealed class UnansweredChatsState extends Equatable {
  const UnansweredChatsState();

  @override
  List<Object?> get props => [];
}

final class UnansweredChatsStateSuccess extends UnansweredChatsState {
  final List<Chat> chats;

  const UnansweredChatsStateSuccess(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class UnansweredChatsStateInProgress extends UnansweredChatsState {
  final List<Chat> chats;

  const UnansweredChatsStateInProgress(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class UnansweredChatsStateError extends UnansweredChatsState {
  final Rejection rejection;

  const UnansweredChatsStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
