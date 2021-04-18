part of 'unanswered_chats_bloc.dart';

@freezed
class UnansweredChatsEvent with _$UnansweredChatsEvent {
  const factory UnansweredChatsEvent.show() = _Show;
  const factory UnansweredChatsEvent.reload() = _Reload;
  const factory UnansweredChatsEvent.loadNextPage() = _LoadNextPage;
  const factory UnansweredChatsEvent.updateFavorites(List<Favorite> favorites) =
      _UpdateFavorites;
}
