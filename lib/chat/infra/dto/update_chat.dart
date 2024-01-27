import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_chat.g.dart';

@JsonSerializable()
class UpdateChat extends Equatable with Model {
  final String subject;

  const UpdateChat(this.subject);

  factory UpdateChat.fromJson(Map<String, dynamic> json) =>
      _$UpdateChatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateChatToJson(this);

  @override
  List<Object?> get props => [subject];
}
