part of 'my_chats_bloc.dart';

sealed class MyChatsState extends Equatable {
  const MyChatsState();

  @override
  List<Object?> get props => [];
}

final class MyChatsStateSuccess extends MyChatsState {
  final List<Chat> chats;

  const MyChatsStateSuccess(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class MyChatsStateInProgress extends MyChatsState {
  final List<Chat> chats;

  const MyChatsStateInProgress(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class MyChatsStateError extends MyChatsState {
  final Rejection rejection;

  const MyChatsStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
