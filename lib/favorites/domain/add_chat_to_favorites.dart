import 'package:askimam/common/domain/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_chat_to_favorites.freezed.dart';
part 'add_chat_to_favorites.g.dart';

@freezed
class AddChatToFavorites with _$AddChatToFavorites, Model {
  factory AddChatToFavorites(int id) = _AddChatToFavorites;

  factory AddChatToFavorites.fromJson(Map<String, dynamic> json) =>
      _$AddChatToFavoritesFromJson(json);
}
