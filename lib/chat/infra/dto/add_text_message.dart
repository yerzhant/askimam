import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_text_message.freezed.dart';
part 'add_text_message.g.dart';

@freezed
class AddTextMessage with _$AddTextMessage, Model {
  factory AddTextMessage(
    int chatId,
    String text,
    String fcmToken,
  ) = _AddTextMessage;

  const AddTextMessage._();

  factory AddTextMessage.fromJson(Map<String, dynamic> json) =>
      _$AddTextMessageFromJson(json);
}
