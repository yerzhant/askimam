part of 'public_chats_bloc.dart';

sealed class PublicChatsEvent extends Equatable {
  const PublicChatsEvent();

  @override
  List<Object?> get props => [];
}

final class PublicChatsEventShow extends PublicChatsEvent {
  const PublicChatsEventShow();
}

final class PublicChatsEventReload extends PublicChatsEvent {
  const PublicChatsEventReload();
}

final class PublicChatsEventLoadNextPage extends PublicChatsEvent {
  const PublicChatsEventLoadNextPage();
}

final class PublicChatsEventUpdateFavorites extends PublicChatsEvent {
  final List<Favorite> favorites;

  const PublicChatsEventUpdateFavorites(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
