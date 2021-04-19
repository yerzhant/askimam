part of 'http_api_client_test.dart';

final httpClient = MockClient((req) async {
  switch (req.method) {
    case 'DELETE':
      if (!_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/suffix/1') {
        var json = ApiResponse.ok().toJsonString();
        return Response(json, 200);
      } else if (req.url.path == '/suffix/2') {
        var json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/suffix/unauth') {
        return Response('', 401, reasonPhrase: 'Unauth');
      } else if (req.url.path == '/suffix/3') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('x');
      }

    case 'GET':
      if (req.url.path == '/list') {
        final json = ApiResponse.data([
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/one') {
        final json = ApiResponse.data(Chat(1, 'subject', false)).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/auth-list' && _isAuthorized(req)) {
        final json = ApiResponse.data([
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/rejection') {
        var json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/not-auth') {
        return Response('', 401, reasonPhrase: 'Unauthorized.');
      } else if (req.url.path == '/nok') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('Unhandled GET: ${req.url.path}');
      }

    default:
      throw Exception('Unhandled method ${req.method}');
  }
});

bool _isAuthorized(Request req) => req.headers['Authorization'] == 'Bearer 123';
