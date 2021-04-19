import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_chat.freezed.dart';
part 'create_chat.g.dart';

@freezed
abstract class CreateChat with _$CreateChat, Model {
  factory CreateChat(
    ChatType type,
    String? subject,
    String text,
    String fcmToken,
  ) = _CreateChat;

  factory CreateChat.fromJson(Map<String, dynamic> json) =>
      _$CreateChatFromJson(json);
}
