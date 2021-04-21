import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/favorites/domain/model/favorite.dart';
import 'package:askimam/favorites/domain/repo/favorite_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorite_bloc_test.mocks.dart';

@GenerateMocks([FavoriteRepository])
void main() {
  late FavoriteBloc bloc;
  final repo = MockFavoriteRepository();

  setUp(() {
    bloc = FavoriteBloc(repo);
  });

  test('Initial state', () {
    expect(bloc.state, const FavoriteState.inProgress([]));
  });

  group('Get my favorites:', () {
    blocTest(
      'should load my favorites',
      build: () {
        when(repo.get()).thenAnswer((_) async => right([
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));
        return bloc;
      },
      act: (_) => bloc.add(const FavoriteEvent.refresh()),
      expect: () => [
        const FavoriteState.inProgress([]),
        FavoriteState([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest(
      'should return an error',
      build: () {
        when(repo.get()).thenAnswer(
          (realInvocation) async => left(Rejection('oops!')),
        );
        return bloc;
      },
      act: (_) => bloc.add(const FavoriteEvent.refresh()),
      expect: () => [
        const FavoriteState.inProgress([]),
        FavoriteState.error(Rejection('oops!')),
      ],
    );

    blocTest(
      'should load favorites after an error',
      build: () {
        when(repo.get()).thenAnswer((_) async => right([
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));
        return bloc;
      },
      seed: () => FavoriteState.error(Rejection('x')),
      act: (_) => bloc.add(const FavoriteEvent.refresh()),
      expect: () => [
        const FavoriteState.inProgress([]),
        FavoriteState([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );
  });

  group('Add a favorite:', () {
    blocTest(
      'should add it',
      build: () {
        when(repo.add(Favorite(1, 1, 'Subject 1'))).thenAnswer(
          (realInvocation) async => none(),
        );
        return bloc;
      },
      seed: () => FavoriteState([
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEvent.add(Favorite(1, 1, 'Subject 1'))),
      expect: () => [
        FavoriteState.inProgress([
          // updating the same myFavorites list
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        FavoriteState([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest(
      'should add it while in progress',
      build: () {
        when(repo.add(Favorite(1, 1, 'Subject 1'))).thenAnswer(
          (realInvocation) async => none(),
        );
        return bloc;
      },
      seed: () => FavoriteState.inProgress([
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEvent.add(Favorite(1, 1, 'Subject 1'))),
      expect: () => [
        FavoriteState([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest(
      'should not add it',
      build: () {
        when(repo.add(Favorite(1, 1, 'Subject 1'))).thenAnswer(
          (realInvocation) async => some(Rejection('reason')),
        );
        return bloc;
      },
      seed: () => FavoriteState([
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEvent.add(Favorite(1, 1, 'Subject 1'))),
      expect: () => [
        FavoriteState.inProgress([
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        FavoriteState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should return a previous error',
      build: () => bloc,
      seed: () => FavoriteState.error(Rejection('reason')),
      act: (_) => bloc.add(FavoriteEvent.add(Favorite(1, 1, 'Subject 1'))),
      expect: () => [],
    );
  });

  group('Delete a favorite:', () {
    blocTest(
      'should delete it',
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
      act: (_) => bloc.add(FavoriteEvent.delete(Favorite(1, 1, 'Subject 1'))),
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
      ],
    );

    blocTest(
      'should return an error',
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
      act: (_) => bloc.add(FavoriteEvent.delete(Favorite(1, 1, 'Subject 1'))),
      expect: () => [
        FavoriteState.inProgress([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        FavoriteState.error(Rejection('error')),
      ],
    );

    blocTest(
      'should return an earlier error',
      build: () => bloc,
      seed: () => FavoriteState.error(Rejection('error')),
      act: (_) => bloc.add(
        FavoriteEvent.delete(Favorite(1, 1, 'Subject 1')),
      ),
      expect: () => [],
    );

    blocTest(
      'should delete it while deleting another one',
      build: () {
        when(repo.delete(Favorite(2, 2, 'Subject 2'))).thenAnswer(
          (realInvocation) async => none(),
        );
        return bloc;
      },
      seed: () => FavoriteState.inProgress([
        Favorite(1, 1, 'Subject 1'),
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEvent.delete(Favorite(2, 2, 'Subject 2'))),
      expect: () => [
        FavoriteState([
          Favorite(1, 1, 'Subject 1'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );
  });

  group('Open tab:', () {
    blocTest(
      'should load favorites on first view',
      build: () {
        when(repo.get()).thenAnswer((_) async => right([
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));
        return bloc;
      },
      act: (_) => bloc.add(const FavoriteEvent.show()),
      expect: () => [
        const FavoriteState.inProgress([]),
        FavoriteState([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest(
      'should just show what it has',
      build: () => bloc,
      seed: () => FavoriteState([
        Favorite(1, 1, 'Subject 1'),
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(const FavoriteEvent.show()),
      expect: () => [],
    );
  });
}
