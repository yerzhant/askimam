part of 'unanswered_chats_bloc.dart';

@freezed
class UnansweredChatsState with _$UnansweredChatsState {
  const factory UnansweredChatsState(List<Chat> chats) = _State;
  const factory UnansweredChatsState.inProgress(List<Chat> chats) = _InProgress;
  const factory UnansweredChatsState.error(Rejection rejection) = _Error;
}
