part of 'http_api_client_test.dart';

final httpClient = MockClient((req) async {
  switch (req.method) {
    case 'GET':
      if (req.url.path == '/list') {
        final json = ApiResponse.data([
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/one' && _isAuthorized(req)) {
        final json = ApiResponse.data(Chat(1, 'subject', false)).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/auth' && !_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/auth-list' && _isAuthorized(req)) {
        final json = ApiResponse.data([
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/rejection') {
        var json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/nok') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('Unhandled ${req.method}: ${req.url.path}');
      }

    case 'PATCH':
      if (!_isAuthorized(req)) {
        return Response('', 401);
      } else if (req.url.path == '/suffix/ok') {
        var json = ApiResponse.ok().toJsonString();
        return Response(json, 200);
      } else if (req.url.path == '/suffix/nok') {
        var json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
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
        var json = ApiResponse.ok().toJsonString();
        return Response(json, 200);
      } else if (req.url.path == '/suffix/nok') {
        var json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
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
