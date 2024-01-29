part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

final class FavoriteEventShow extends FavoriteEvent {
  const FavoriteEventShow();
}

final class FavoriteEventRefresh extends FavoriteEvent {
  const FavoriteEventRefresh();
}

final class FavoriteEventAdd extends FavoriteEvent {
  final Chat chat;

  const FavoriteEventAdd(this.chat);

  @override
  List<Object?> get props => [chat];
}

final class FavoriteEventDelete extends FavoriteEvent {
  final int chatId;

  const FavoriteEventDelete(this.chatId);

  @override
  List<Object?> get props => [chatId];
}
