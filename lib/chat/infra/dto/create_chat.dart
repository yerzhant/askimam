import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_chat.g.dart';

@JsonSerializable()
class CreateChat extends Equatable with Model {
  final ChatType type;
  final String? subject;
  final String text;
  final String fcmToken;

  const CreateChat(this.type, this.subject, this.text, this.fcmToken);

  factory CreateChat.fromJson(Map<String, dynamic> json) =>
      _$CreateChatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CreateChatToJson(this);

  @override
  List<Object?> get props => [type, subject, text, fcmToken];
}
