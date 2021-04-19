import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_chat.freezed.dart';
part 'update_chat.g.dart';

@freezed
class UpdateChat with _$UpdateChat, Model {
  const UpdateChat._();
  factory UpdateChat(String subject) = _UpdateChat;

  factory UpdateChat.fromJson(Map<String, dynamic> json) =>
      _$UpdateChatFromJson(json);
}
