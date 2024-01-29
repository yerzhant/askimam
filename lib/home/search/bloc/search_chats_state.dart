part of 'search_chats_bloc.dart';

sealed class SearchChatsState extends Equatable {
  const SearchChatsState();

  @override
  List<Object?> get props => [];
}

final class SearchChatsStateSuccess extends SearchChatsState {
  final List<Chat> chats;

  const SearchChatsStateSuccess(this.chats);

  @override
  List<Object?> get props => [chats];
}

final class SearchChatsStateInProgress extends SearchChatsState {
  const SearchChatsStateInProgress();
}

final class SearchChatsStateError extends SearchChatsState {
  final Rejection rejection;

  const SearchChatsStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
