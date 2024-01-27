part of 'search_chats_bloc.dart';

sealed class SearchChatsEvent extends Equatable {
  const SearchChatsEvent();

  @override
  List<Object?> get props => [];
}

final class SearchChatsEventFind extends SearchChatsEvent {
  final String phrase;

  const SearchChatsEventFind(this.phrase);

  @override
  List<Object?> get props => [phrase];
}
