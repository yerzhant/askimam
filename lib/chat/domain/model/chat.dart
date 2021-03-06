import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat, Model {
  factory Chat(
    int id,
    ChatType type,
    int askedBy,
    String subject,
    DateTime updatedAt, {
    @Default(false) bool isFavorite,
    @Default(false) bool isViewedByImam,
    @Default(false) bool isViewedByInquirer,
    List<Message>? messages,
  }) = _Chat;

  const Chat._();

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

enum ChatType { Public, Private }
