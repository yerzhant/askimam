import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:askimam/home/favorites/domain/repo/favorite_repository.dart';
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
    expect(bloc.state, const FavoriteStateInProgress([]));
  });

  group('Get my favorites:', () {
    blocTest<FavoriteBloc, FavoriteState>(
      'should load my favorites',
      build: () {
        when(repo.get()).thenAnswer((_) async => right(const [
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));
        return bloc;
      },
      act: (_) => bloc.add(const FavoriteEventRefresh()),
      expect: () => [
        const FavoriteStateInProgress([]),
        const FavoriteStateSuccess([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should return an error',
      build: () {
        when(repo.get()).thenAnswer(
          (realInvocation) async => left(Rejection('oops!')),
        );
        return bloc;
      },
      act: (_) => bloc.add(const FavoriteEventRefresh()),
      expect: () => [
        const FavoriteStateInProgress([]),
        FavoriteStateError(Rejection('oops!')),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should load favorites after an error',
      build: () {
        when(repo.get()).thenAnswer((_) async => right(const [
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));
        return bloc;
      },
      seed: () => FavoriteStateError(Rejection('x')),
      act: (_) => bloc.add(const FavoriteEventRefresh()),
      expect: () => [
        const FavoriteStateInProgress([]),
        const FavoriteStateSuccess([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );
  });

  group('Add a favorite:', () {
    blocTest<FavoriteBloc, FavoriteState>(
      'should add it',
      build: () {
        when(repo.add(Chat(
          1,
          ChatType.Public,
          1,
          'Subject 1',
          DateTime.parse('2021-05-01'),
        ))).thenAnswer(
          (realInvocation) async => none(),
        );
        when(repo.get()).thenAnswer((_) async => right(const [
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));

        return bloc;
      },
      seed: () => const FavoriteStateSuccess([
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEventAdd(Chat(
        1,
        ChatType.Public,
        1,
        'Subject 1',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        const FavoriteStateInProgress([
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        const FavoriteStateInProgress([]),
        const FavoriteStateSuccess([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should add it while in progress',
      build: () {
        when(repo.add(Chat(
          1,
          ChatType.Public,
          1,
          'Subject 1',
          DateTime.parse('2021-05-01'),
        ))).thenAnswer(
          (realInvocation) async => none(),
        );
        when(repo.get()).thenAnswer((_) async => right(const [
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));

        return bloc;
      },
      seed: () => const FavoriteStateInProgress([
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEventAdd(Chat(
        1,
        ChatType.Public,
        1,
        'Subject 1',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        const FavoriteStateInProgress([]),
        const FavoriteStateSuccess([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should not add it',
      build: () {
        when(repo.add(Chat(
          1,
          ChatType.Public,
          1,
          'Subject 1',
          DateTime.parse('2021-05-01'),
        ))).thenAnswer(
          (realInvocation) async => some(Rejection('reason')),
        );
        return bloc;
      },
      seed: () => const FavoriteStateSuccess([
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(FavoriteEventAdd(Chat(
        1,
        ChatType.Public,
        1,
        'Subject 1',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        const FavoriteStateInProgress([
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        FavoriteStateError(Rejection('reason')),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should return a previous error',
      build: () => bloc,
      seed: () => FavoriteStateError(Rejection('reason')),
      act: (_) => bloc.add(FavoriteEventAdd(Chat(
        1,
        ChatType.Public,
        1,
        'Subject 1',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [],
    );
  });

  group('Delete a favorite:', () {
    blocTest<FavoriteBloc, FavoriteState>(
      'should delete it',
      build: () {
        when(repo.delete(1)).thenAnswer((realInvocation) async => none());
        return bloc;
      },
      seed: () => const FavoriteStateSuccess([
        Favorite(1, 1, 'Subject 1'),
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(const FavoriteEventDelete(1)),
      expect: () => [
        const FavoriteStateInProgress([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        const FavoriteStateSuccess([
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should return an error',
      build: () {
        when(repo.delete(1)).thenAnswer((_) async => some(Rejection('error')));
        return bloc;
      },
      seed: () => const FavoriteStateSuccess([
        Favorite(1, 1, 'Subject 1'),
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(const FavoriteEventDelete(1)),
      expect: () => [
        const FavoriteStateInProgress([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
        FavoriteStateError(Rejection('error')),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should return an earlier error',
      build: () => bloc,
      seed: () => FavoriteStateError(Rejection('error')),
      act: (_) => bloc.add(const FavoriteEventDelete(1)),
      expect: () => [],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should delete it while deleting another one',
      build: () {
        when(repo.delete(2)).thenAnswer((realInvocation) async => none());
        return bloc;
      },
      seed: () => const FavoriteStateInProgress([
        Favorite(1, 1, 'Subject 1'),
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(const FavoriteEventDelete(2)),
      expect: () => [
        const FavoriteStateSuccess([
          Favorite(1, 1, 'Subject 1'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );
  });

  group('Open tab:', () {
    blocTest<FavoriteBloc, FavoriteState>(
      'should load favorites on first view',
      build: () {
        when(repo.get()).thenAnswer((_) async => right(const [
              Favorite(1, 1, 'Subject 1'),
              Favorite(2, 2, 'Subject 2'),
              Favorite(3, 3, 'Subject 3'),
            ]));
        return bloc;
      },
      act: (_) => bloc.add(const FavoriteEventShow()),
      expect: () => [
        const FavoriteStateInProgress([]),
        const FavoriteStateSuccess([
          Favorite(1, 1, 'Subject 1'),
          Favorite(2, 2, 'Subject 2'),
          Favorite(3, 3, 'Subject 3'),
        ]),
      ],
    );

    blocTest<FavoriteBloc, FavoriteState>(
      'should just show what it has',
      build: () => bloc,
      seed: () => const FavoriteStateSuccess([
        Favorite(1, 1, 'Subject 1'),
        Favorite(2, 2, 'Subject 2'),
        Favorite(3, 3, 'Subject 3'),
      ]),
      act: (_) => bloc.add(const FavoriteEventShow()),
      expect: () => [],
    );
  });
}
