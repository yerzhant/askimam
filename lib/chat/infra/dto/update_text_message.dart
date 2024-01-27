import 'package:askimam/common/domain/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_text_message.g.dart';

@JsonSerializable()
class UpdateTextMessage with Model {
  final String text;
  final String fcmToken;

  const UpdateTextMessage(this.text, this.fcmToken);

  factory UpdateTextMessage.fromJson(Map<String, dynamic> json) =>
      _$UpdateTextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UpdateTextMessageToJson(this);
}
