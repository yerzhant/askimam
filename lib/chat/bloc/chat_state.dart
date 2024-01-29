part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

final class ChatStateSuccess extends ChatState {
  final Chat chat;
  final Rejection? rejection;
  final bool isInProgress;
  final bool isSuccess;

  const ChatStateSuccess(
    this.chat, {
    this.rejection,
    this.isInProgress = false,
    this.isSuccess = false,
  });

  @override
  List<Object?> get props => [chat, rejection, isInProgress, isSuccess];
}

final class ChatStateInProgress extends ChatState {
  const ChatStateInProgress();
}

final class ChatStateError extends ChatState {
  final Rejection rejection;

  const ChatStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
