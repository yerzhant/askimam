import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat, Model {
  const Chat._();
  factory Chat(
    int id,
    String subject,
    bool isFavorite, {
    List<Message>? messages,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

enum ChatType { Public, Private }
