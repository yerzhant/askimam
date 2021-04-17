part of 'public_chats_bloc.dart';

@freezed
class PublicChatsEvent with _$PublicChatsEvent {
  const factory PublicChatsEvent.show() = _Show;
  const factory PublicChatsEvent.reload() = _Reload;
  const factory PublicChatsEvent.loadNextPage() = _LoadNextPage;
}
