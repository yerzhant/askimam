part of 'my_chats_bloc.dart';

sealed class MyChatsEvent extends Equatable {
  const MyChatsEvent();

  @override
  List<Object?> get props => [];
}

final class MyChatsEventShow extends MyChatsEvent {
  const MyChatsEventShow();
}

final class MyChatsEventReload extends MyChatsEvent {
  const MyChatsEventReload();
}

final class MyChatsEventLoadNextPage extends MyChatsEvent {
  const MyChatsEventLoadNextPage();
}

final class MyChatsEventUpdateFavorites extends MyChatsEvent {
  final List<Favorite> favorites;

  const MyChatsEventUpdateFavorites(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class MyChatsEventAdd extends MyChatsEvent {
  final ChatType type;
  final String? subject;
  final String text;

  const MyChatsEventAdd(this.type, this.subject, this.text);

  @override
  List<Object?> get props => [type, subject, text];
}

final class MyChatsEventDelete extends MyChatsEvent {
  final Chat chat;

  const MyChatsEventDelete(this.chat);

  @override
  List<Object?> get props => [chat];
}
