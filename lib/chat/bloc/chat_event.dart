part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

final class ChatEventRefresh extends ChatEvent {
  final int id;

  const ChatEventRefresh(this.id);

  @override
  List<Object?> get props => [id];
}

final class ChatEventReturnToUnaswered extends ChatEvent {
  const ChatEventReturnToUnaswered();
}

final class ChatEventUpdateSubject extends ChatEvent {
  final String subject;

  const ChatEventUpdateSubject(this.subject);

  @override
  List<Object?> get props => [subject];
}

final class ChatEventAddText extends ChatEvent {
  final String text;

  const ChatEventAddText(this.text);

  @override
  List<Object?> get props => [text];
}

final class ChatEventAddAudio extends ChatEvent {
  final File file;
  final String duration;

  const ChatEventAddAudio(this.file, this.duration);

  @override
  List<Object?> get props => [file, duration];
}

final class ChatEventDeleteMessage extends ChatEvent {
  final int id;

  const ChatEventDeleteMessage(this.id);

  @override
  List<Object?> get props => [id];
}

final class ChatEventUpdateTextMessage extends ChatEvent {
  final int id;
  final String text;

  const ChatEventUpdateTextMessage(this.id, this.text);

  @override
  List<Object?> get props => [id, text];
}
