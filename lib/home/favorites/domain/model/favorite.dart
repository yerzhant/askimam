import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favorite.g.dart';

@JsonSerializable()
class Favorite extends Equatable with Model {
  final int id;
  final int chatId;
  final String subject;

  const Favorite(this.id, this.chatId, this.subject);

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FavoriteToJson(this);

  @override
  List<Object?> get props => [id, chatId, subject];
}
