import 'package:equatable/equatable.dart';

class Rejection extends Equatable {
  final String reason;

  Rejection(this.reason) {
    if (reason.trim().isEmpty) {
      throw ArgumentError("Empty or blank string");
    }
  }

  String get message => _messages.entries
      .firstWhere(
        (entry) => RegExp(entry.key).hasMatch(reason),
        orElse: () => MapEntry('', reason),
      )
      .value;

  @override
  List<Object?> get props => [reason];
}

extension RejectionExt on Exception {
  Rejection asRejection() => Rejection(toString());
}

const _messages = {
  'FCM token is unavailable.': 'FCM токен недоступен.',
  r"You're not allowed.*": 'Операция запрещена.',
  r'^SocketException: .*': 'Ошибка соединения.',
  'XMLHttpRequest error.': 'Ошибка соединения.',
  'Deletion of a last message is disallowed':
      'Удаление последнего сообщения запрещено.',
  'Who are you?': 'Вы не авторизованы.',
  'Unauthorized.': 'Доступ запрещён.',
};
