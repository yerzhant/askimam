part of 'public_chats_bloc.dart';

@freezed
class PublicChatsState with _$PublicChatsState {
  const factory PublicChatsState(List<Chat> chats) = _State;
  const factory PublicChatsState.inProgress(List<Chat> chats) = _InProgress;
  const factory PublicChatsState.error(Rejection rejection) = _Error;
}
