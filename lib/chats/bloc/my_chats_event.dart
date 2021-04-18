part of 'my_chats_bloc.dart';

@freezed
class MyChatsEvent with _$MyChatsEvent {
  const factory MyChatsEvent.show() = _Show;
  const factory MyChatsEvent.reload() = _Reload;
  const factory MyChatsEvent.loadNextPage() = _LoadNextPage;
  const factory MyChatsEvent.updateFavorites(List<Favorite> favorites) =
      _UpdateFavorites;

  const factory MyChatsEvent.add(ChatType type, String? subject, String text) =
      _Add;

  const factory MyChatsEvent.delete(Chat chat) = _Delete;
}
