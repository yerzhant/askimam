import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/common/domain/model/model.dart';
import 'package:equatable/equatable.dart';

class Chat extends Equatable with Model {
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

  Chat copyWith({
    bool? isFavorite,
    List<Message>? messages,
  }) =>
      Chat(
        id,
        type,
        askedBy,
        subject,
        updatedAt,
        isFavorite: isFavorite ?? this.isFavorite,
        isViewedByImam: isViewedByImam,
        isViewedByInquirer: isViewedByInquirer,
        messages: messages ?? this.messages,
      );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'askedBy': askedBy,
        'subject': subject,
        'updatedAt': updatedAt,
        'isFavorite': isFavorite,
        'isViewedByImam': isViewedByImam,
        'isViewedByInquirer': isViewedByInquirer,
        'messages': messages,
      };

  @override
  List<Object?> get props => [
        id,
        type,
        askedBy,
        subject,
        updatedAt,
        isFavorite,
        isViewedByImam,
        isViewedByInquirer,
        messages,
      ];
}

// ignore: constant_identifier_names
enum ChatType { Public, Private }
