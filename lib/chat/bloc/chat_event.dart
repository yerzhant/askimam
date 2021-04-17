part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.reloadPublic() = _ReloadPublic;
  const factory ChatEvent.loadNextPublicPage() = _LoadNextPublicPage;
}
