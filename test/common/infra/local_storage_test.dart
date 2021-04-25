import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/infra/local_storage.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late LocalStorage storage;

  setUp(() {
    storage = LocalStorage();
  });

  group('Load authentication:', () {
    test('should load it', () async {
      SharedPreferences.setMockInitialValues({
        'jwt': '123',
        'user-id': 1,
        'user-type': 'UserType.Inquirer',
      });

      final result = await storage.loadAuthentication();

      expect(result, right(Authentication('123', 1, UserType.Inquirer)));
    });

    test('should not load it', () async {
      SharedPreferences.setMockInitialValues({});

      final result = await storage.loadAuthentication();

      expect(result, left(Rejection('no-data')));
    });
  });

  group('Save authentication', () {
    test('should save it', () async {
      SharedPreferences.setMockInitialValues({
        'jwt': '555',
        'user-id': 555,
        'user-type': 'UserType.Imam',
      });

      final result = await storage
          .saveAuthentication(Authentication('123', 1, UserType.Inquirer));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('jwt'), '123');
      expect(prefs.getInt('user-id'), 1);
      expect(prefs.getString('user-type'), UserType.Inquirer.toString());
      expect(result, right(Authentication('123', 1, UserType.Inquirer)));
    });
  });

  group('Clear authentication', () {
    test('should clear it', () async {
      SharedPreferences.setMockInitialValues({
        'jwt': '123',
        'user-id': 1,
        'user-type': 'UserType.Inquirer',
      });

      final result = await storage.clearAuthentication();

      final prefs = await SharedPreferences.getInstance();
      expect(result, none());
      expect(prefs.getString('jwt'), null);
      expect(prefs.getInt('user-id'), null);
      expect(prefs.getString('user-type'), null);
    });
  });
}
