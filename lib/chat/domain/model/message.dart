class Message {
  final int id;
  final MessageType type;
  final String text;
  final String? author;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? audio;
  final String? duration;

  const Message(
    this.id,
    this.type,
    this.text,
    this.author,
    this.createdAt,
    this.updatedAt, {
    this.audio,
    this.duration,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        json['id'],
        json['type'],
        json['text'],
        json['author'],
        json['createdAt'],
        json['updatedAt'],
        audio: json['audio'],
        duration: json['duration'],
      );
}

// ignore: constant_identifier_names
enum MessageType { Text, Audio }
