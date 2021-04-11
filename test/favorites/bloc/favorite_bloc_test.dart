import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:askimam/favorites/domain/favorite_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([FavoriteRepository])
void main() {
  group('Favorite Bloc', () {
    final repo = MockFavoriteRepository();

    late FavoriteBloc bloc;

    setUp(() {
      bloc = FavoriteBloc(repo);
    });

    test('initial state', () {
      expect(bloc.state, FavoriteState.inProgress([]));
    });

    group('Get my favorites', () {
      blocTest('should load my favorites',
          build: () {
            when(repo.getMyFavorites()).thenAnswer((_) async => right([
                  Favorite(1, 1, 'Subject 1'),
                  Favorite(2, 2, 'Subject 2'),
                  Favorite(3, 3, 'Subject 3'),
                ]));
            return bloc;
          },
          act: (_) => bloc.add(FavoriteEvent.refresh()),
          expect: () => [
                FavoriteState.inProgress([]),
                FavoriteState([
                  Favorite(1, 1, 'Subject 1'),
                  Favorite(2, 2, 'Subject 2'),
                  Favorite(3, 3, 'Subject 3'),
                ]),
              ]);
      blocTest('should return an error',
          build: () {
            when(repo.getMyFavorites()).thenAnswer(
              (realInvocation) async => left(Rejection('oops!')),
            );
            return bloc;
          },
          act: (_) => bloc.add(FavoriteEvent.refresh()),
          expect: () => [
                FavoriteState.inProgress([]),
                FavoriteState.error(Rejection('oops!')),
              ]);
    });

    group('Delete a favorite', () {
      blocTest('should delete it',
          build: () {
            when(repo.delete(Favorite(1, 1, 'Subject 1'))).thenAnswer(
              (realInvocation) async => none(),
            );
            return bloc;
          },
          seed: () => FavoriteState([
                Favorite(1, 1, 'Subject 1'),
                Favorite(2, 2, 'Subject 2'),
                Favorite(3, 3, 'Subject 3'),
              ]),
          act: (_) => bloc.add(
                FavoriteEvent.delete(Favorite(1, 1, 'Subject 1')),
              ),
          expect: () => [
                FavoriteState.inProgress([
                  Favorite(1, 1, 'Subject 1'),
                  Favorite(2, 2, 'Subject 2'),
                  Favorite(3, 3, 'Subject 3'),
                ]),
                FavoriteState([
                  Favorite(2, 2, 'Subject 2'),
                  Favorite(3, 3, 'Subject 3'),
                ]),
              ]);

      blocTest('should return an error',
          build: () {
            when(repo.delete(Favorite(1, 1, 'Subject 1'))).thenAnswer(
              (realInvocation) async => some(Rejection('error')),
            );
            return bloc;
          },
          seed: () => FavoriteState([
                Favorite(1, 1, 'Subject 1'),
                Favorite(2, 2, 'Subject 2'),
                Favorite(3, 3, 'Subject 3'),
              ]),
          act: (_) => bloc.add(
                FavoriteEvent.delete(Favorite(1, 1, 'Subject 1')),
              ),
          expect: () => [
                FavoriteState.inProgress([
                  Favorite(1, 1, 'Subject 1'),
                  Favorite(2, 2, 'Subject 2'),
                  Favorite(3, 3, 'Subject 3'),
                ]),
                FavoriteState.error(Rejection('error')),
              ]);

      // TODO: more edge cases are needed
    });

    // TODO: add Open a chat
  });
}
