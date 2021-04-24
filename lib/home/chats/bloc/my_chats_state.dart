part of 'my_chats_bloc.dart';

@freezed
class MyChatsState with _$MyChatsState {
  const factory MyChatsState(List<Chat> chats) = _State;
  const factory MyChatsState.inProgress(List<Chat> chats) = _InProgress;
  const factory MyChatsState.error(Rejection rejection) = _Error;
}
