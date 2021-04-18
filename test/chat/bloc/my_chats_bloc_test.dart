import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

import 'my_chats_bloc_test.mocks.dart';

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

@GenerateMocks([ChatRepository])
void main() {
  late MyChatsBloc bloc;
  late FavoriteBloc favoriteBloc;
  final repo = MockChatRepository();

  setUpAll(() {
    mocktail.registerFallbackValue<FavoriteState>(FavoriteState([]));
    mocktail.registerFallbackValue<FavoriteEvent>(FavoriteEvent.show());
  });

  setUp(() {
    favoriteBloc = MockFavoriteBloc();
    bloc = MyChatsBloc(repo, favoriteBloc, 20);
  });

  test('Initial state', () {
    expect(bloc.state, MyChatsState.inProgress([]));
  });

  group('Load first page:', () {
    blocTest(
      'should load chats',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ])
      ],
    );

    blocTest(
      'should be rejected',
      build: () {
        when(repo.getMy(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should load chats after an error',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ]),
      ],
    );

    blocTest(
      'should reload chats',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
            Chat(4, 'subject', true),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
          Chat(4, 'subject', true),
        ]),
      ],
    );
  });

  group('Load next page:', () {
    blocTest(
      'should load next page',
      build: () {
        when(repo.getMy(20, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [
        MyChatsState.inProgress([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
          // late testing!
          ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
        ]),
        MyChatsState([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
          ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
        ]),
      ],
    );

    blocTest(
      'should ignore double next page loading',
      build: () => bloc,
      seed: () => MyChatsState.inProgress([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should be rejected on loading next page',
      build: () {
        when(repo.getMy(20, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => MyChatsState([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [
        MyChatsState.inProgress([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
        ]),
        MyChatsState.error(Rejection('reason')),
      ],
    );
  });

  group('Show tab:', () {
    blocTest(
      'should load first page',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(MyChatsEvent.show()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ])
      ],
    );

    blocTest(
      'should not load a page',
      build: () => bloc,
      seed: () => MyChatsState([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.show()),
      expect: () => [],
    );
  });

  group('Listen to favorites changes:', () {
    blocTest(
      'should set a flag',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(FavoriteState([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsState([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      expect: () => [
        MyChatsState([
          Chat(1, 'subject', true),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ])
      ],
    );

    blocTest(
      'should reset a flag',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(FavoriteState([
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsState([
        Chat(1, 'subject', true),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      expect: () => [
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ])
      ],
    );

    blocTest(
      'should nothing happen',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.fromIterable([
            FavoriteState.inProgress([
              Favorite(3, 3, 'subject'),
            ]),
            FavoriteState.error(Rejection('reason')),
          ]),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsState([
        Chat(1, 'subject', true),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      expect: () => [],
    );

    blocTest(
      'should nothing happen either',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(FavoriteState([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsState.inProgress([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      expect: () => [],
    );

    blocTest(
      'should nothing happen as well',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(FavoriteState([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsState.error(Rejection('reason')),
      expect: () => [],
    );
  });
}
