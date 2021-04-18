part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.refresh(int id) = _Refresh;
  const factory ChatEvent.returnToUnaswered() = _ReturnToUnaswered;
  const factory ChatEvent.updateSubject(String subject) = _UpdateSubject;
  const factory ChatEvent.addText(String text) = _AddText;
  const factory ChatEvent.deleteMessage(int id) = _DeleteMessage;
}
