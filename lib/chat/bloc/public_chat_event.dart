part of 'public_chat_bloc.dart';

@freezed
class PublicChatEvent with _$PublicChatEvent {
  const factory PublicChatEvent.reload() = _Reload;
  const factory PublicChatEvent.loadNextPage() = _LoadNextPage;
}
