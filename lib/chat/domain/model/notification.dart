import 'package:equatable/equatable.dart';

final class Notification extends Equatable {
  final DateTime recievedOn;
  final String? title;
  final String? body;

  const Notification({required this.recievedOn, this.title, this.body});

  @override
  List<Object?> get props => [recievedOn, title, body];
}
