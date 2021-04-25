part of 'favorite_bloc.dart';

@freezed
class FavoriteEvent with _$FavoriteEvent {
  const factory FavoriteEvent.show() = _Show;
  const factory FavoriteEvent.refresh() = _Refresh;
  const factory FavoriteEvent.add(Chat chat) = _Add;
  const factory FavoriteEvent.delete(int chatId) = _Delete;
}
