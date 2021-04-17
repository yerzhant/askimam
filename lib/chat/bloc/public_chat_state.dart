part of 'public_chat_bloc.dart';

@freezed
class PublicChatState with _$PublicChatState {
  const factory PublicChatState(List<Chat> chats) = _State;
  const factory PublicChatState.inProgress(List<Chat> chats) = _InProgress;
  const factory PublicChatState.error(Rejection rejection) = _Error;
}
