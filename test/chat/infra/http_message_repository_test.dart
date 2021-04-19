import 'package:askimam/chat/domain/repo/message_repository.dart';
import 'package:askimam/chat/infra/dto/add_text_message.dart';
import 'package:askimam/chat/infra/dto/update_text_message.dart';
import 'package:askimam/chat/infra/http_message_repository.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_message_repository_test.mocks.dart';

@GenerateMocks([ApiClient, NotificationService])
void main() {
  late ApiClient api;
  late NotificationService nService;
  late MessageRepository repo;

  setUp(() {
    api = MockApiClient();
    nService = MockNotificationService();
    repo = HttpMessageRepository(api, nService);
  });

  group('Add text:', () {
    test('should add a text message', () async {
      when(nService.getFcmToken()).thenAnswer((_) async => right('123'));
      when(api.post('messages', AddTextMessage(1, 'text', '123')))
          .thenAnswer((_) async => none());

      final result = await repo.addText(1, 'text');

      expect(result, none());
      verify(nService.getFcmToken()).called(1);
      verify(api.post('messages', AddTextMessage(1, 'text', '123'))).called(1);
    });

    test('should not add it', () async {
      when(nService.getFcmToken()).thenAnswer((_) async => right('123'));
      when(api.post('messages', AddTextMessage(1, 'text', '123')))
          .thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo.addText(1, 'text');

      expect(result, some(Rejection('reason')));
    });

    test('should not add it either', () async {
      when(nService.getFcmToken())
          .thenAnswer((_) async => left(Rejection('reason')));

      final result = await repo.addText(1, 'text');

      expect(result, some(Rejection('reason')));
    });
  });

  group('Update text:', () {
    test('should update a text message', () async {
      when(nService.getFcmToken()).thenAnswer((_) async => right('123'));
      when(api.patchWithBody('messages/1/2', UpdateTextMessage('text', '123')))
          .thenAnswer((_) async => none());

      final result = await repo.updateText(1, 2, 'text');

      expect(result, none());
      verify(nService.getFcmToken()).called(1);
      verify(api.patchWithBody(
              'messages/1/2', UpdateTextMessage('text', '123')))
          .called(1);
    });

    test('should not add it', () async {
      when(nService.getFcmToken()).thenAnswer((_) async => right('123'));
      when(api.patchWithBody('messages/1/2', UpdateTextMessage('text', '123')))
          .thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo.updateText(1, 2, 'text');

      expect(result, some(Rejection('reason')));
    });

    test('should not add it either', () async {
      when(nService.getFcmToken())
          .thenAnswer((_) async => left(Rejection('reason')));

      final result = await repo.updateText(1, 2, 'text');

      expect(result, some(Rejection('reason')));
    });
  });

  group('Delete a message:', () {
    test('should delete it', () async {
      when(api.delete('messages/1/2')).thenAnswer((_) async => none());

      final result = await repo.delete(1, 2);

      expect(result, none());
      verify(api.delete('messages/1/2')).called(1);
    });

    test('should not delete it', () async {
      when(api.delete('messages/1/2'))
          .thenAnswer((_) async => some(Rejection('reason')));

      final result = await repo.delete(1, 2);

      expect(result, some(Rejection('reason')));
    });
  });
}
