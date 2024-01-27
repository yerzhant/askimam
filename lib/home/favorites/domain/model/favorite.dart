import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';

class Favorite extends Equatable with Model {
  final int id;
  final int chatId;
  final String subject;

  const Favorite(this.id, this.chatId, this.subject);

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      Favorite(json['id'], json['chatId'], json['subject']);

  @override
  List<Object?> get props => [id, chatId, subject];

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'chatId': chatId,
        'subject': subject,
      };
}
