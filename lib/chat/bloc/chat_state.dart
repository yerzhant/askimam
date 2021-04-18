part of 'chat_bloc.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState(
    Chat chat, {
    Rejection? rejection,
    @Default(false) bool isInProgress,
    @Default(false) bool isSuccess,
  }) = _State;
  const factory ChatState.inProgress() = _InProgress;
  const factory ChatState.error(Rejection rejection) = _Error;
}
