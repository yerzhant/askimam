part of 'unanswered_chats_bloc.dart';

sealed class UnansweredChatsEvent extends Equatable {
  const UnansweredChatsEvent();

  @override
  List<Object?> get props => [];
}

final class UnansweredChatsEventShow extends UnansweredChatsEvent {
  const UnansweredChatsEventShow();
}

final class UnansweredChatsEventReload extends UnansweredChatsEvent {
  const UnansweredChatsEventReload();
}

final class UnansweredChatsEventDelete extends UnansweredChatsEvent {
  final Chat chat;

  const UnansweredChatsEventDelete(this.chat);

  @override
  List<Object?> get props => [chat];
}

final class UnansweredChatsEventLoadNextPage extends UnansweredChatsEvent {
  const UnansweredChatsEventLoadNextPage();
}

final class UnansweredChatsEventUpdateFavorites extends UnansweredChatsEvent {
  final List<Favorite> favorites;

  const UnansweredChatsEventUpdateFavorites(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
