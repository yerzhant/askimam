import 'package:askimam/common/domain/api_client.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:askimam/favorites/infra/http_favorite_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_favorite_repository_test.mocks.dart';

@GenerateMocks([ApiClient])
void main() {
  final apiClient = MockApiClient();
  final repo = HttpFavoriteRepository(apiClient);

  group('Get my favorites', () {
    test('should return an ordered list', () async {
      final list = [
        Favorite(1, 1, 'subject'),
        Favorite(2, 2, 'subject'),
        Favorite(3, 3, 'subject'),
      ];

      when(apiClient.getList<Favorite>('favorites'))
          .thenAnswer((_) async => right(list));

      final result = await repo.get();

      expect(result, right(list));
    });

    test('should return an error', () async {
      when(apiClient.getList<Favorite>('favorites'))
          .thenAnswer((_) async => left(Rejection('error')));

      final result = await repo.get();

      expect(result, left(Rejection('error')));
    });
  });

  group('Delete a favorite', () {
    test('should delete it', () async {
      when(apiClient.delete('favorites/1')).thenAnswer((_) async => none());

      final result = await repo.delete(Favorite(1, 1, 'subject'));

      expect(result, none());
    });

    test('should return an error', () async {
      when(apiClient.delete('favorites/1'))
          .thenAnswer((_) async => some(Rejection('error')));

      final result = await repo.delete(Favorite(1, 1, 'subject'));

      expect(result, some(Rejection('error')));
    });
  });
}
