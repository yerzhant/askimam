import 'package:freezed_annotation/freezed_annotation.dart';

part 'rejection.freezed.dart';

@freezed
class Rejection with _$Rejection {
  @Assert('reason.trim().isNotEmpty', 'reason may not be empty')
  factory Rejection(String reason) = _Rejection;

  Rejection._();

  String get message =>
      _messages.entries
          .firstWhereOrNull((entry) => RegExp(entry.key).hasMatch(reason))
          ?.value ??
      reason;
}

extension RejectionExt on Exception {
  Rejection asRejection() => Rejection(toString());
}

const _messages = {
  'FCM token is unavailable.': 'FCM токен недоступен.',
  r"You're not allowed.*": 'Операция запрещена.',
  r'^SocketException: .*': 'Ошибка соединения.',
  'XMLHttpRequest error.': 'Ошибка соединения.',
  'Who are you?': 'Вы не авторизованы.',
  'Unauthorized.': 'Доступ запрещён.',
};
