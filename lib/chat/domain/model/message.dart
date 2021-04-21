import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
abstract class Message with _$Message {
  factory Message(
    int id,
    MessageType type,
    String text,
    String? author,
    DateTime createdAt,
    DateTime? updatedAt,
  ) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

// ignore: constant_identifier_names
enum MessageType { Text, Audio }
