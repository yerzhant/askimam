import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/common/infra/http_api_client.dart';
import 'package:askimam/common/web/api_response.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

const apiUrl = 'https://server';

void main() {
  final httpClient = MockClient((req) async {
    switch (req.method) {
      case 'DELETE':
        if (req.headers['Authorization'] != 'Bearer 123') {
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
        if (req.url.path == '/suffix') {
          final json = ApiResponse.data([
            Favorite(1, 1, 'Тема'),
            Favorite(2, 2, 'Тема'),
          ]).toJsonUtf8();
          return Response.bytes(json, 200);
        } else {
          throw Exception('x');
        }

      default:
        throw Exception('Unhandled method');
    }
  });

  final apiClient = HttpApiClient(httpClient, apiUrl, '123');

  group('Get list', () {
    test('should return a list', () async {
      final result = await apiClient.getList<Favorite>('suffix');

      expect(
        result.getOrElse(() => []),
        [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ],
      );
    });
  });

  group('Delete', () {
    test('should return none', () async {
      final result = await apiClient.delete('suffix/1');

      expect(result, none());
    });

    test('should return some rejection reason', () async {
      final result = await apiClient.delete('suffix/2');

      expect(result, some(Rejection('Что-то пошло не так')));
    });

    test('should return some nok', () async {
      final result = await apiClient.delete('suffix/3');

      expect(result, some(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result = await apiClient.delete('suffix/4');

      expect(result, some(Rejection('Exception: x')));
    });
  });
}
