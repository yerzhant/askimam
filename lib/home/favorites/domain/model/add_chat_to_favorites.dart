import 'package:askimam/common/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_chat_to_favorites.g.dart';

@JsonSerializable()
class AddChatToFavorites with Model {
  final int id;

  const AddChatToFavorites(this.id);

  factory AddChatToFavorites.fromJson(Map<String, dynamic> json) =>
      _$AddChatToFavoritesFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddChatToFavoritesToJson(this);
}
