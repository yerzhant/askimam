import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/infra/dto/create_chat.dart';
import 'package:askimam/chat/infra/dto/update_chat.dart';
import 'package:askimam/chat/infra/http_chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:askimam/common/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_message_repository_test.mocks.dart';

@GenerateMocks([ApiClient, NotificationService])
void main() {
  late ApiClient api;
  late NotificationService notificationService;
  late HttpChatRepository repo;

  setUp(() {
    api = MockApiClient();
    notificationService = MockNotificationService();
    repo = HttpChatRepository(api, notificationService);
  });

  group('Get public:', () {
    test('should get it', () async {
      when(api.getList<Chat>('chats/public/0/20'))
          .thenAnswer((_) async => right([Chat(1, 'subject')]));

      final resutl = await repo.getPublic(0, 20);

      expect(resutl.getOrElse(() => Todo), [Chat(1, 'subject')]);
    });

    test('should not get it', () async {
      when(api.getList<Chat>('chats/public/0/20'))
          .thenAnswer((_) async => left(Rejection('reason')));

      final resutl = await repo.getPublic(0, 20);

      expect(resutl, left(Rejection('reason')));
    });
  });

  group('Get my:', () {
    test('should get it', () async {
      when(api.getList<Chat>('chats/my/0/20'))
          .thenAnswer((_) async => right([Chat(1, 'subject')]));

      final resutl = await repo.getMy(0, 20);

      expect(resutl.getOrElse(() => Todo), [Chat(1, 'subject')]);
    });

    test('should not get it', () async {
      when(api.getList<Chat>('chats/my/0/20'))
          .thenAnswer((_) async => left(Rejection('reason')));

      final resutl = await repo.getMy(0, 20);

      expect(resutl, left(Rejection('reason')));
    });
  });

  group('Get unanswered:', () {
    test('should get it', () async {
      when(api.getList<Chat>('chats/unanswered/0/20'))
          .thenAnswer((_) async => right([Chat(1, 'subject')]));

      final resutl = await repo.getUnanswered(0, 20);

      expect(resutl.getOrElse(() => Todo), [Chat(1, 'subject')]);
    });

    test('should not get it', () async {
      when(api.getList<Chat>('chats/unanswered/0/20'))
          .thenAnswer((_) async => left(Rejection('reason')));

      final resutl = await repo.getUnanswered(0, 20);

      expect(resutl, left(Rejection('reason')));
    });
  });

  group('Read a chat:', () {
    test('should get it', () async {
      when(api.get<Chat>('chats/messages/1')).thenAnswer((_) async => right(
            Chat(1, 'subject', messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210419'), null),
            ]),
          ));

      final resutl = await repo.get(1);

      expect(
        resutl,
        right(
          Chat(1, 'subject', messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210419'), null),
          ]),
        ),
      );
    });

    test('should not get it', () async {
      when(api.get<Chat>('chats/messages/1'))
          .thenAnswer((_) async => left(Rejection('reason')));

      final resutl = await repo.get(1);

      expect(resutl, left(Rejection('reason')));
    });
  });

  group('Add a chat:', () {
    test('should add it', () async {
      when(notificationService.getFcmToken())
          .thenAnswer((_) async => right('123'));
      when(api.post(
              'chats', CreateChat(ChatType.Public, 'subject', 'text', '123')))
          .thenAnswer((_) async => none());

      final resutl = await repo.add(ChatType.Public, 'subject', 'text');

      expect(resutl, none());
    });

    test('should not add it', () async {
      when(notificationService.getFcmToken())
          .thenAnswer((_) async => right('123'));
      when(api.post(
              'chats', CreateChat(ChatType.Public, 'subject', 'text', '123')))
          .thenAnswer((_) async => some(Rejection('reason')));

      final resutl = await repo.add(ChatType.Public, 'subject', 'text');

      expect(resutl, some(Rejection('reason')));
    });

    test('should not add it either', () async {
      when(notificationService.getFcmToken())
          .thenAnswer((_) async => left(Rejection('reason')));

      final resutl = await repo.add(ChatType.Public, 'subject', 'text');

      expect(resutl, some(Rejection('reason')));
    });
  });

  group('Update a chat:', () {
    test('should update it', () async {
      when(api.patchWithBody('chats/1', UpdateChat('subject')))
          .thenAnswer((_) async => none());

      final resutl = await repo.updateSubject(1, 'subject');

      expect(resutl, none());
    });

    test('should not update it', () async {
      when(api.patchWithBody('chats/1', UpdateChat('subject')))
          .thenAnswer((_) async => some(Rejection('reason')));

      final resutl = await repo.updateSubject(1, 'subject');

      expect(resutl, some(Rejection('reason')));
    });
  });

  group('Delete a chat:', () {
    test('should delete it', () async {
      when(api.delete('chats/1')).thenAnswer((_) async => none());

      final resutl = await repo.delete(Chat(1, 'subject'));

      expect(resutl, none());
    });

    test('should not delete it', () async {
      when(api.delete('chats/1'))
          .thenAnswer((_) async => some(Rejection('reason')));

      final resutl = await repo.delete(Chat(1, 'subject'));

      expect(resutl, some(Rejection('reason')));
    });
  });

  group('Set viewed flag:', () {
    test('should set it', () async {
      when(api.patch('chats/1/viewed-by')).thenAnswer((_) async => none());

      final resutl = await repo.setViewedFlag(1);

      expect(resutl, none());
    });

    test('should not set it', () async {
      when(api.patch('chats/1/viewed-by'))
          .thenAnswer((_) async => some(Rejection('reason')));

      final resutl = await repo.setViewedFlag(1);

      expect(resutl, some(Rejection('reason')));
    });
  });

  group('Return to unanswered ones:', () {
    test('should return it', () async {
      when(api.patch('chats/1/return-to-unanswered'))
          .thenAnswer((_) async => none());

      final resutl = await repo.returnToUnanswered(1);

      expect(resutl, none());
    });

    test('should not return it', () async {
      when(api.patch('chats/1/return-to-unanswered'))
          .thenAnswer((_) async => some(Rejection('reason')));

      final resutl = await repo.returnToUnanswered(1);

      expect(resutl, some(Rejection('reason')));
    });
  });
}
