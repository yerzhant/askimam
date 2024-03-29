part of 'http_api_client_test.dart';

final httpClient = MockClient((req) async {
  switch (req.method) {
    case 'GET':
      if (req.url.path == '/list') {
        final json = ApiResponse.data(const [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/one' && _isAuthorized(req)) {
        final json = ApiResponse.data(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('2021-05-01'), null),
                Message(2, MessageType.Audio, 'audio', 'author',
                    DateTime.parse('2021-05-01'), null,
                    audio: 'audio.mp3', duration: '01:23'),
              ]),
        ).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/auth' && !_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/auth-list' && _isAuthorized(req)) {
        final json = ApiResponse.data(const [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/rejection') {
        final json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/nok') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('Unhandled ${req.method}: ${req.url.path}');
      }

    case 'POST':
      if (!_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/suffix/ok') {
        if (listEquals(
          req.bodyBytes,
          const LoginRequest('login', 'password', 'fcm').toJsonUtf8(),
        )) {
          final json = ApiResponse.data(
            const Authentication('123', 1, UserType.Inquirer, 'fcm'),
          ).toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/ok-chat') {
        if (listEquals(
          req.bodyBytes,
          const CreateChat(ChatType.Public, 'Тема', 'Текст', '123')
              .toJsonUtf8(),
        )) {
          final json = ApiResponse.ok().toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/ok-message') {
        if (listEquals(
          req.bodyBytes,
          const AddTextMessage(1, 'Текст', '123').toJsonUtf8(),
        )) {
          final json = ApiResponse.ok().toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/ok-favorite') {
        if (listEquals(
          req.bodyBytes,
          const AddChatToFavorites(1).toJsonUtf8(),
        )) {
          final json = ApiResponse.ok().toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/nok') {
        final json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/suffix/500') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('Unhandled ${req.method}: ${req.url.path}');
      }

    case 'PATCH':
      if (!_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/suffix/ok') {
        final json = ApiResponse.ok().toJsonString();
        return Response(json, 200);
      } else if (req.url.path == '/suffix/ok-body-chat') {
        if (listEquals(req.bodyBytes, const UpdateChat('Тема').toJsonUtf8())) {
          final json = ApiResponse.ok().toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/ok-body-message') {
        if (listEquals(
          req.bodyBytes,
          const UpdateTextMessage('Тема', '123').toJsonUtf8(),
        )) {
          final json = ApiResponse.ok().toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/ok-body-fcm-token') {
        if (listEquals(
          req.bodyBytes,
          const UpdateFcmToken('old', 'new').toJsonUtf8(),
        )) {
          final json = ApiResponse.ok().toJsonString();
          return Response(json, 200);
        } else {
          return Response('', 400);
        }
      } else if (req.url.path == '/suffix/nok') {
        final json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/suffix/500') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('Unhandled ${req.method}: ${req.url.path}');
      }

    case 'DELETE':
      if (!_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/suffix/ok') {
        final json = ApiResponse.ok().toJsonString();
        return Response(json, 200);
      } else if (req.url.path == '/suffix/nok') {
        final json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/suffix/500') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('Unhandled ${req.method}: ${req.url.path}');
      }

    default:
      throw Exception('Unhandled method ${req.method}');
  }
});

bool _isAuthorized(Request req) => req.headers['Authorization'] == 'Bearer 123';
