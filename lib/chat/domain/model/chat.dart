import 'package:askimam/chat/domain/model/message.dart';

class Chat {
  final int id;
  final ChatType type;
  final int askedBy;
  final String subject;
  final DateTime updatedAt;
  final bool isFavorite;
  final bool isViewedByImam;
  final bool isViewedByInquirer;
  final List<Message>? messages;

  const Chat(
    this.id,
    this.type,
    this.askedBy,
    this.subject,
    this.updatedAt, {
    this.isFavorite = false,
    this.isViewedByImam = false,
    this.isViewedByInquirer = false,
    this.messages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        json['id'],
        json['type'],
        json['askedBy'],
        json['subject'],
        json['updatedAt'],
        isFavorite: json['isFavorite'],
        isViewedByImam: json['isViewedByImam'],
        isViewedByInquirer: json['isViewedByInquirer'],
        messages: json['messages'],
      );
}

// ignore: constant_identifier_names
enum ChatType { Public, Private }
