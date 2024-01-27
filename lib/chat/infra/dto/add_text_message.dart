import 'package:askimam/common/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_text_message.g.dart';

@JsonSerializable()
class AddTextMessage with Model {
  final int chatId;
  final String text;
  final String fcmToken;

  const AddTextMessage(this.chatId, this.text, this.fcmToken);

  factory AddTextMessage.fromJson(Map<String, dynamic> json) =>
      _$AddTextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddTextMessageToJson(this);
}
