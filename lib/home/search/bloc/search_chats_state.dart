part of 'search_chats_bloc.dart';

@freezed
class SearchChatsState with _$SearchChatsState {
  const factory SearchChatsState(List<Chat> chats) = _State;
  const factory SearchChatsState.inProgress() = _InProgress;
  const factory SearchChatsState.error(Rejection rejection) = _Error;
}
