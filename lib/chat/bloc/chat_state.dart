part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState(List<Chat> public) = _State;
  const factory ChatState.inProgress(List<Chat> public) = _InProgress;
  const factory ChatState.error(Rejection rejection) = _Error;
}
