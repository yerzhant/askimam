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
    mocktail.registerFallbackValue<FavoriteState>(const FavoriteState([]));
    mocktail.registerFallbackValue<FavoriteEvent>(const FavoriteEvent.show());
  });

  setUp(() {
    favoriteBloc = MockFavoriteBloc();
    bloc = MyChatsBloc(repo, favoriteBloc, 20);
  });

  test('Initial state', () {
    expect(bloc.state, const MyChatsState.inProgress([]));
  });

  group('Load first page:', () {
    blocTest(
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
      act: (_) => bloc.add(const MyChatsEvent.reload()),
      expect: () => [
        const MyChatsState.inProgress([]),
        MyChatsState([
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

    blocTest(
      'should be rejected',
      build: () {
        when(repo.getMy(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const MyChatsEvent.reload()),
      expect: () => [
        const MyChatsState.inProgress([]),
        MyChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
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
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(const MyChatsEvent.reload()),
      expect: () => [
        const MyChatsState.inProgress([]),
        MyChatsState([
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

    blocTest(
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
      seed: () => MyChatsState([
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
      act: (_) => bloc.add(const MyChatsEvent.reload()),
      expect: () => [
        const MyChatsState.inProgress([]),
        MyChatsState([
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
    blocTest(
      'should load next page',
      build: () {
        when(repo.getMy(20, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(
                20,
                (i) => Chat(i + 21, ChatType.Public, 1, 'subject',
                    DateTime.parse('2021-05-01'))),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState([
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
      act: (_) => bloc.add(const MyChatsEvent.loadNextPage()),
      expect: () => [
        MyChatsState.inProgress([
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
        MyChatsState([
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

    blocTest(
      'should ignore double next page loading',
      build: () => bloc,
      seed: () => MyChatsState.inProgress([
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
      act: (_) => bloc.add(const MyChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(const MyChatsEvent.loadNextPage()),
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
      act: (_) => bloc.add(const MyChatsEvent.loadNextPage()),
      expect: () => [
        MyChatsState.inProgress([
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
      act: (_) => bloc.add(const MyChatsEvent.show()),
      expect: () => [
        const MyChatsState.inProgress([]),
        MyChatsState([
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

    blocTest(
      'should not load a page',
      build: () => bloc,
      seed: () => MyChatsState([
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
      act: (_) => bloc.add(const MyChatsEvent.show()),
      expect: () => [],
    );
  });

  group('Add a chat:', () {
    blocTest(
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
      seed: () => MyChatsState([
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
          bloc.add(const MyChatsEvent.add(ChatType.Public, 'subject', 'text')),
      expect: () => [
        MyChatsState.inProgress([
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
        const MyChatsState.inProgress([]),
        MyChatsState([
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

    blocTest(
      'should not add it',
      build: () {
        when(repo.add(ChatType.Public, 'subject', 'text'))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => MyChatsState([
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
          bloc.add(const MyChatsEvent.add(ChatType.Public, 'subject', 'text')),
      expect: () => [
        MyChatsState.inProgress([
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
        MyChatsState.error(Rejection('reason')),
      ],
    );
  });

  group('Delete a chat:', () {
    blocTest(
      'should delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => MyChatsState([
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
      act: (_) => bloc.add(MyChatsEvent.delete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        MyChatsState.inProgress([
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
        MyChatsState([
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
            () => favoriteBloc.add(const FavoriteEvent.refresh()),
          )
          .called(1),
    );

    blocTest(
      'should not delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => MyChatsState([
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
      act: (_) => bloc.add(MyChatsEvent.delete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [
        MyChatsState.inProgress([
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
        MyChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should happen nothing',
      build: () => bloc,
      seed: () => MyChatsState.inProgress([
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
      act: (_) => bloc.add(MyChatsEvent.delete(Chat(
        1,
        ChatType.Public,
        1,
        'subject',
        DateTime.parse('2021-05-01'),
      ))),
      expect: () => [],
    );

    blocTest(
      'should happen nothing either',
      build: () => bloc,
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(MyChatsEvent.delete(Chat(
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
        MyChatsState([
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
        MyChatsState([
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
