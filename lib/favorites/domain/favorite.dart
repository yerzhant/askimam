import 'package:askimam/common/domain/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

@freezed
class Favorite with _$Favorite, Model {
  factory Favorite(
    int id,
    int chatId,
    String subject,
  ) = _Favorite;

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
