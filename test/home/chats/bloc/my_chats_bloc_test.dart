import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
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
    mocktail.registerFallbackValue(const FavoriteStateSuccess([]));
    mocktail.registerFallbackValue(const FavoriteEventShow());
  });

  setUp(() {
    favoriteBloc = MockFavoriteBloc();
    bloc = MyChatsBloc(repo, favoriteBloc, 20);
  });

  test('Initial state', () {
    expect(bloc.state, const MyChatsStateInProgress([]));
  });

  group('Load first page:', () {
    blocTest<MyChatsBloc, MyChatsState>(
      'should load chats',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(
              1,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              2,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              3,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
              isFavorite: true,
            ),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(const MyChatsEventReload()),
      expect: () => [
        const MyChatsStateInProgress([]),
        MyChatsStateSuccess([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ])
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should be rejected',
      build: () {
        when(repo.getMy(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const MyChatsEventReload()),
      expect: () => [
        const MyChatsStateInProgress([]),
        MyChatsStateError(Rejection('reason')),
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should load chats after an error',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(
              1,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              2,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              3,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
              isFavorite: true,
            ),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(const MyChatsEventReload()),
      expect: () => [
        const MyChatsStateInProgress([]),
        MyChatsStateSuccess([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ]),
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should reload chats',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(
              1,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              2,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              3,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
              isFavorite: true,
            ),
            Chat(
              4,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
              isFavorite: true,
            ),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(const MyChatsEventReload()),
      expect: () => [
        const MyChatsStateInProgress([]),
        MyChatsStateSuccess([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          Chat(
            4,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ]),
      ],
    );
  });

  group('Load next page:', () {
    blocTest<MyChatsBloc, MyChatsState>(
      'should load next page',
      build: () {
        when(repo.getMy(1, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(
                20,
                (i) => Chat(i + 21, ChatType.Public, 1, 'subject',
                    DateTime.parse('2021-05-01'))),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        ...List.generate(
            18,
            (i) => Chat(i + 1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))),
        Chat(
          19,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          20,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(const MyChatsEventLoadNextPage()),
      expect: () => [
        MyChatsStateInProgress([
          ...List.generate(
              18,
              (i) => Chat(i + 1, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01'))),
          Chat(
            19,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            20,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          // late testing!
          ...List.generate(
              20,
              (i) => Chat(i + 21, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01'))),
        ]),
        MyChatsStateSuccess([
          ...List.generate(
              18,
              (i) => Chat(i + 1, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01'))),
          Chat(
            19,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            20,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          ...List.generate(
              20,
              (i) => Chat(i + 21, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01'))),
        ]),
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should ignore double next page loading',
      build: () => bloc,
      seed: () => MyChatsStateInProgress([
        ...List.generate(
            18,
            (i) => Chat(i + 1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))),
        Chat(
          19,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          20,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(const MyChatsEventLoadNextPage()),
      expect: () => [],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => MyChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(const MyChatsEventLoadNextPage()),
      expect: () => [],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should be rejected on loading next page',
      build: () {
        when(repo.getMy(1, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        ...List.generate(
            18,
            (i) => Chat(i + 1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))),
        Chat(
          19,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          20,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(const MyChatsEventLoadNextPage()),
      expect: () => [
        MyChatsStateInProgress([
          ...List.generate(
              18,
              (i) => Chat(i + 1, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01'))),
          Chat(
            19,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            20,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ]),
        MyChatsStateError(Rejection('reason')),
      ],
    );
  });

  group('Show tab:', () {
    blocTest<MyChatsBloc, MyChatsState>(
      'should load first page',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(
              1,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              2,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
            ),
            Chat(
              3,
              ChatType.Public,
              1,
              'subject',
              DateTime.parse('2021-05-01'),
              isFavorite: true,
            ),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(const MyChatsEventShow()),
      expect: () => [
        const MyChatsStateInProgress([]),
        MyChatsStateSuccess([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ])
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should not load a page',
      build: () => bloc,
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(const MyChatsEventShow()),
      expect: () => [],
    );
  });

  group('Add a chat:', () {
    blocTest<MyChatsBloc, MyChatsState>(
      'should add it',
      build: () {
        when(repo.add(ChatType.Public, 'subject', 'text'))
            .thenAnswer((_) async => none());
        when(repo.getMy(0, 20)).thenAnswer((_) async => right([
              Chat(4, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01')),
              Chat(
                3,
                ChatType.Public,
                1,
                'subject',
                DateTime.parse('2021-05-01'),
                isFavorite: true,
              ),
              Chat(2, ChatType.Public, 1, 'subject',
                  DateTime.parse('2021-05-01')),
            ]));
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
      ]),
      act: (_) =>
          bloc.add(const MyChatsEventAdd(ChatType.Public, 'subject', 'text')),
      expect: () => [
        MyChatsStateInProgress([
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
        ]),
        const MyChatsStateInProgress([]),
        MyChatsStateSuccess([
          Chat(
            4,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
        ]),
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should not add it',
      build: () {
        when(repo.add(ChatType.Public, 'subject', 'text'))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
      ]),
      act: (_) =>
          bloc.add(const MyChatsEventAdd(ChatType.Public, 'subject', 'text')),
      expect: () => [
        MyChatsStateInProgress([
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
        ]),
        MyChatsStateError(Rejection('reason')),
      ],
    );
  });

  group('Delete a chat:', () {
    blocTest<MyChatsBloc, MyChatsState>(
      'should delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(MyChatsEventDelete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        MyChatsStateInProgress([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ]),
        MyChatsStateSuccess([
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ]),
      ],
      verify: (_) => mocktail
          .verify(
            () => favoriteBloc.add(const FavoriteEventRefresh()),
          )
          .called(1),
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should not delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(MyChatsEventDelete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        MyChatsStateInProgress([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ]),
        MyChatsStateError(Rejection('reason')),
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should happen nothing',
      build: () => bloc,
      seed: () => MyChatsStateInProgress([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      act: (_) => bloc.add(MyChatsEventDelete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should happen nothing either',
      build: () => bloc,
      seed: () => MyChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(MyChatsEventDelete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [],
    );
  });

  group('Listen to favorites changes:', () {
    blocTest<MyChatsBloc, MyChatsState>(
      'should set a flag',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      expect: () => [
        MyChatsStateSuccess([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ])
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should reset a flag',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      expect: () => [
        MyChatsStateSuccess([
          Chat(
            1,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            2,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
          ),
          Chat(
            3,
            ChatType.Public,
            1,
            'subject',
            DateTime.parse('2021-05-01'),
            isFavorite: true,
          ),
        ])
      ],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should nothing happen',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.fromIterable([
            const FavoriteStateInProgress([
              Favorite(3, 3, 'subject'),
            ]),
            FavoriteStateError(Rejection('reason')),
          ]),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsStateSuccess([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      expect: () => [],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should nothing happen either',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsStateInProgress([
        Chat(
          1,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          2,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
        ),
        Chat(
          3,
          ChatType.Public,
          1,
          'subject',
          DateTime.parse('2021-05-01'),
          isFavorite: true,
        ),
      ]),
      expect: () => [],
    );

    blocTest<MyChatsBloc, MyChatsState>(
      'should nothing happen as well',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return MyChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => MyChatsStateError(Rejection('reason')),
      expect: () => [],
    );
  });
}
