import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/domain/model/login_request.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/infra/dto/add_text_message.dart';
import 'package:askimam/chat/infra/dto/create_chat.dart';
import 'package:askimam/chat/infra/dto/update_chat.dart';
import 'package:askimam/chat/infra/dto/update_text_message.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/infra/dto/api_response.dart';
import 'package:askimam/common/infra/http_api_client.dart';
import 'package:askimam/home/favorites/domain/model/add_chat_to_favorites.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

part 'http_api_client_test.client.dart';

const apiUrl = 'https://server';

void main() {
  late ApiClient apiClient;

  setUp(() {
    apiClient = HttpApiClient(httpClient, apiUrl);
    apiClient.setJwt('123');
  });

  group('Get one:', () {
    test('should return an item', () async {
      final result = await apiClient.get<Chat>('one');

      expect(
          result,
          right(Chat(1, ChatType.Public, 1, 'subject', messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('2021-05-01'), null),
            Message(2, MessageType.Audio, 'audio', 'author',
                DateTime.parse('2021-05-01'), null,
                audio: 'audio.mp3', duration: '01:23'),
          ])));
    });

    test('should return a rejection', () async {
      final result = await apiClient.get<Chat>('rejection');

      expect(result, left(Rejection('Что-то пошло не так')));
    });

    test('should return an Unauthenticated', () async {
      apiClient.resetJwt();

      final result = await apiClient.get<Chat>('auth');

      expect(result, left(Rejection('Unauthorized.')));
    });

    test('should return a nok', () async {
      final result = await apiClient.get<Chat>('nok');

      expect(result, left(Rejection('Response: 500, boom!')));
    });

    test('should return an exception', () async {
      final result = await apiClient.get<Chat>('x');

      expect(result, left(Rejection('Exception: Unhandled GET: /x')));
    });
  });

  group('Get list:', () {
    test('should return a list', () async {
      apiClient.resetJwt();

      final result = await apiClient.getList<Favorite>('list');

      expect(
        result.getOrElse(() => []),
        [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ],
      );
    });

    test('should return an auth list', () async {
      final result = await apiClient.getList<Favorite>('auth-list');

      expect(
        result.getOrElse(() => []),
        [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ],
      );
    });

    test('should return a rejection', () async {
      final result = await apiClient.getList<Favorite>('rejection');

      expect(result, left(Rejection('Что-то пошло не так')));
    });

    test('should return an unauthorized', () async {
      apiClient.resetJwt();

      final result = await apiClient.getList<Favorite>('auth');

      expect(result, left(Rejection('Unauthorized.')));
    });

    test('should return a nok', () async {
      final result = await apiClient.getList<Favorite>('nok');

      expect(result, left(Rejection('Response: 500, boom!')));
    });

    test('should return an exception', () async {
      final result = await apiClient.getList<Favorite>('x');

      expect(result, left(Rejection('Exception: Unhandled GET: /x')));
    });
  });

  group('Post:', () {
    test('should return none - chat', () async {
      final result = await apiClient.post('suffix/ok-chat',
          CreateChat(ChatType.Public, 'Тема', 'Текст', '123'));

      expect(result, none());
    });

    test('should return none - message', () async {
      final result = await apiClient.post(
          'suffix/ok-message', AddTextMessage(1, 'Текст', '123'));

      expect(result, none());
    });

    test('should return none - favorite', () async {
      final result =
          await apiClient.post('suffix/ok-favorite', AddChatToFavorites(1));

      expect(result, none());
    });

    test('should return some rejection reason', () async {
      final result = await apiClient.post(
          'suffix/nok', CreateChat(ChatType.Public, 'Тема', 'Текст', '123'));

      expect(result, some(Rejection('Что-то пошло не так')));
    });

    test('should return an unauthorized', () async {
      apiClient.resetJwt();

      final result = await apiClient.post(
          'suffix/ok-message', AddTextMessage(1, 'Текст', '123'));

      expect(result, some(Rejection('Unauthorized.')));
    });

    test('should return some nok', () async {
      final result =
          await apiClient.post('suffix/500', AddTextMessage(1, 'Текст', '123'));

      expect(result, some(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result =
          await apiClient.post('suffix/4', AddTextMessage(1, 'Текст', '123'));

      expect(result, some(Rejection('Exception: Unhandled POST: /suffix/4')));
    });
  });
  group('Post and get response:', () {
    test('should return response', () async {
      final result =
          await apiClient.postAndGetResponse<Authentication, LoginRequest>(
              'suffix/ok', LoginRequest('login', 'password', 'fcm'));

      expect(result, right(Authentication('123', 1, UserType.Inquirer)));
    });

    test('should return some rejection reason', () async {
      final result =
          await apiClient.postAndGetResponse<Authentication, LoginRequest>(
              'suffix/nok', LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('Что-то пошло не так')));
    });

    test('should return an unauthorized', () async {
      apiClient.resetJwt();

      final result =
          await apiClient.postAndGetResponse<Authentication, LoginRequest>(
              'suffix/ok', LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('Unauthorized.')));
    });

    test('should return some nok', () async {
      final result =
          await apiClient.postAndGetResponse<Authentication, LoginRequest>(
              'suffix/500', LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result =
          await apiClient.postAndGetResponse<Authentication, LoginRequest>(
              'suffix/4', LoginRequest('login', 'password', 'fcm'));

      expect(result, left(Rejection('Exception: Unhandled POST: /suffix/4')));
    });
  });

  group('Patch:', () {
    test('should return none', () async {
      final result = await apiClient.patch('suffix/ok');

      expect(result, none());
    });

    test('should return some rejection reason', () async {
      final result = await apiClient.patch('suffix/nok');

      expect(result, some(Rejection('Что-то пошло не так')));
    });

    test('should return an unauthorized', () async {
      apiClient.resetJwt();

      final result = await apiClient.patch('suffix/ok');

      expect(result, some(Rejection('Unauthorized.')));
    });

    test('should return some nok', () async {
      final result = await apiClient.patch('suffix/500');

      expect(result, some(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result = await apiClient.patch('suffix/4');

      expect(result, some(Rejection('Exception: Unhandled PATCH: /suffix/4')));
    });
  });

  group('Patch with body:', () {
    test('should return none - chat', () async {
      final result = await apiClient.patchWithBody(
          'suffix/ok-body-chat', UpdateChat('Тема'));

      expect(result, none());
    });

    test('should return none - message', () async {
      final result = await apiClient.patchWithBody(
          'suffix/ok-body-message', UpdateTextMessage('Тема', '123'));

      expect(result, none());
    });

    test('should return some rejection reason', () async {
      final result =
          await apiClient.patchWithBody('suffix/nok', UpdateChat('Тема'));

      expect(result, some(Rejection('Что-то пошло не так')));
    });

    test('should return an unauthorized', () async {
      apiClient.resetJwt();

      final result =
          await apiClient.patchWithBody('suffix/ok-body', UpdateChat('Тема'));

      expect(result, some(Rejection('Unauthorized.')));
    });

    test('should return some nok', () async {
      final result =
          await apiClient.patchWithBody('suffix/500', UpdateChat('Тема'));

      expect(result, some(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result =
          await apiClient.patchWithBody('suffix/4', UpdateChat('Тема'));

      expect(result, some(Rejection('Exception: Unhandled PATCH: /suffix/4')));
    });
  });

  group('Delete:', () {
    test('should return none', () async {
      final result = await apiClient.delete('suffix/ok');

      expect(result, none());
    });

    test('should return some rejection reason', () async {
      final result = await apiClient.delete('suffix/nok');

      expect(result, some(Rejection('Что-то пошло не так')));
    });

    test('should return an unauthorized', () async {
      apiClient.resetJwt();

      final result = await apiClient.delete('suffix/ok');

      expect(result, some(Rejection('Unauthorized.')));
    });

    test('should return some nok', () async {
      final result = await apiClient.delete('suffix/500');

      expect(result, some(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result = await apiClient.delete('suffix/4');

      expect(result, some(Rejection('Exception: Unhandled DELETE: /suffix/4')));
    });
  });
}
