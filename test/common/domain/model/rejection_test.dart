import 'package:askimam/common/domain/model/rejection.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('should convert:', () {
    const map = {
      'SocketException: abc': 'Ошибка соединения.',
      'Unauthorized.': 'Доступ запрещён.',
    };

    map.forEach((key, value) {
      test('$key => $value', () {
        expect(Rejection(key).message, value);
      });
    });
  });
}
