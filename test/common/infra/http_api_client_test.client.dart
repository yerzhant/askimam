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
      } else if (req.url.path == '/auth-list' && _isAuthorized(req)) {
        final json = ApiResponse.data([
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ]).toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/list-rejection') {
        var json = ApiResponse.error('Что-то пошло не так').toJsonUtf8();
        return Response.bytes(json, 200);
      } else if (req.url.path == '/list-nok') {
        return Response('', 500, reasonPhrase: 'boom!');
      } else {
        throw Exception('x');
      }

    default:
      throw Exception('Unhandled method');
  }
});
