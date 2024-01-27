import 'package:askimam/common/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_chat.g.dart';

@JsonSerializable()
class UpdateChat with Model {
  final String subject;

  const UpdateChat(this.subject);

  factory UpdateChat.fromJson(Map<String, dynamic> json) =>
      _$UpdateChatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateChatToJson(this);
}
