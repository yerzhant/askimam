import 'package:askimam/common/domain/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_text_message.freezed.dart';
part 'update_text_message.g.dart';

@freezed
class UpdateTextMessage with _$UpdateTextMessage, Model {
  factory UpdateTextMessage(
    String text,
    String fcmToken,
  ) = _UpdateTextMessage;

  const UpdateTextMessage._();

  factory UpdateTextMessage.fromJson(Map<String, dynamic> json) =>
      _$UpdateTextMessageFromJson(json);
}
