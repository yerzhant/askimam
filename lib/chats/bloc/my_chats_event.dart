part of 'my_chats_bloc.dart';

@freezed
class MyChatsEvent with _$MyChatsEvent {
  const factory MyChatsEvent.show() = _Show;
  const factory MyChatsEvent.reload() = _Reload;
  const factory MyChatsEvent.delete(Chat chat) = _Delete;
  const factory MyChatsEvent.loadNextPage() = _LoadNextPage;
  const factory MyChatsEvent.updateFavorites(List<Favorite> favorites) =
      _UpdateFavorites;
}
