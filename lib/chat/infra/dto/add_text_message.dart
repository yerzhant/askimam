import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_text_message.g.dart';

@JsonSerializable()
class AddTextMessage extends Equatable with Model {
  final int chatId;
  final String text;
  final String fcmToken;

  const AddTextMessage(this.chatId, this.text, this.fcmToken);

  factory AddTextMessage.fromJson(Map<String, dynamic> json) =>
      _$AddTextMessageFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AddTextMessageToJson(this);

  @override
  List<Object?> get props => [chatId, text, fcmToken];
}
