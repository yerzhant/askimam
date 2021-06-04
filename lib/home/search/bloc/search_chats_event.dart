part of 'search_chats_bloc.dart';

@freezed
class SearchChatsEvent with _$SearchChatsEvent {
  const factory SearchChatsEvent.find(String phrase) = _Find;
}
