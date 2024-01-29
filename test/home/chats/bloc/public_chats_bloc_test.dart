import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

import 'public_chats_bloc_test.mocks.dart';

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

@GenerateMocks([ChatRepository])
void main() {
  late PublicChatsBloc bloc;
  late FavoriteBloc favoriteBloc;
  final repo = MockChatRepository();

  setUpAll(() {
    mocktail.registerFallbackValue(const FavoriteStateSuccess([]));
    mocktail.registerFallbackValue(const FavoriteEventShow());
  });

  setUp(() {
    favoriteBloc = MockFavoriteBloc();
    bloc = PublicChatsBloc(repo, favoriteBloc, 20);
  });

  test('Initial state', () {
    expect(bloc.state, const PublicChatsStateInProgress([]));
  });

  group('Load first page:', () {
    blocTest<PublicChatsBloc, PublicChatsState>(
      'should load public chats',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
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
      act: (_) => bloc.add(const PublicChatsEventReload()),
      expect: () => [
        const PublicChatsStateInProgress([]),
        PublicChatsStateSuccess([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should be rejected',
      build: () {
        when(repo.getPublic(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const PublicChatsEventReload()),
      expect: () => [
        const PublicChatsStateInProgress([]),
        PublicChatsStateError(Rejection('reason')),
      ],
    );

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should load public chats after an error',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
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
      seed: () => PublicChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(const PublicChatsEventReload()),
      expect: () => [
        const PublicChatsStateInProgress([]),
        PublicChatsStateSuccess([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should reload public chats',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
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
      seed: () => PublicChatsStateSuccess([
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
      act: (_) => bloc.add(const PublicChatsEventReload()),
      expect: () => [
        const PublicChatsStateInProgress([]),
        PublicChatsStateSuccess([
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
    blocTest<PublicChatsBloc, PublicChatsState>(
      'should load next page',
      build: () {
        when(repo.getPublic(1, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(
                20,
                (i) => Chat(
                      i + 21,
                      ChatType.Public,
                      1,
                      'subject',
                      DateTime.parse('2021-05-01'),
                    )),
          ]),
        );
        return bloc;
      },
      seed: () => PublicChatsStateSuccess([
        ...List.generate(
            18,
            (i) => Chat(
                  i + 1,
                  ChatType.Public,
                  1,
                  'subject',
                  DateTime.parse('2021-05-01'),
                )),
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
      act: (_) => bloc.add(const PublicChatsEventLoadNextPage()),
      expect: () => [
        PublicChatsStateInProgress([
          ...List.generate(
              18,
              (i) => Chat(
                    i + 1,
                    ChatType.Public,
                    1,
                    'subject',
                    DateTime.parse('2021-05-01'),
                  )),
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
              (i) => Chat(
                    i + 21,
                    ChatType.Public,
                    1,
                    'subject',
                    DateTime.parse('2021-05-01'),
                  )),
        ]),
        PublicChatsStateSuccess([
          ...List.generate(
              18,
              (i) => Chat(
                    i + 1,
                    ChatType.Public,
                    1,
                    'subject',
                    DateTime.parse('2021-05-01'),
                  )),
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
              (i) => Chat(
                    i + 21,
                    ChatType.Public,
                    1,
                    'subject',
                    DateTime.parse('2021-05-01'),
                  )),
        ]),
      ],
    );

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should ignore double next page loading',
      build: () => bloc,
      seed: () => PublicChatsStateInProgress([
        ...List.generate(
            18,
            (i) => Chat(
                  i + 1,
                  ChatType.Public,
                  1,
                  'subject',
                  DateTime.parse('2021-05-01'),
                )),
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
      act: (_) => bloc.add(const PublicChatsEventLoadNextPage()),
      expect: () => [],
    );

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => PublicChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(const PublicChatsEventLoadNextPage()),
      expect: () => [],
    );

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should be rejected on loading next page',
      build: () {
        when(repo.getPublic(1, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => PublicChatsStateSuccess([
        ...List.generate(
            18,
            (i) => Chat(
                  i + 1,
                  ChatType.Public,
                  1,
                  'subject',
                  DateTime.parse('2021-05-01'),
                )),
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
      act: (_) => bloc.add(const PublicChatsEventLoadNextPage()),
      expect: () => [
        PublicChatsStateInProgress([
          ...List.generate(
              18,
              (i) => Chat(
                    i + 1,
                    ChatType.Public,
                    1,
                    'subject',
                    DateTime.parse('2021-05-01'),
                  )),
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
        PublicChatsStateError(Rejection('reason')),
      ],
    );
  });

  group('Show tab:', () {
    blocTest<PublicChatsBloc, PublicChatsState>(
      'should load first page',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
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
      act: (_) => bloc.add(const PublicChatsEventShow()),
      expect: () => [
        const PublicChatsStateInProgress([]),
        PublicChatsStateSuccess([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should not load a page',
      build: () => bloc,
      seed: () => PublicChatsStateSuccess([
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
      act: (_) => bloc.add(const PublicChatsEventShow()),
      expect: () => [],
    );
  });

  group('Listen to favorites changes:', () {
    blocTest<PublicChatsBloc, PublicChatsState>(
      'should set a flag',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsStateSuccess([
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
        PublicChatsStateSuccess([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should reset a flag',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(3, 3, 'subject'),
          ])),
        );
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsStateSuccess([
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
        PublicChatsStateSuccess([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
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
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsStateSuccess([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should nothing happen either',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsStateInProgress([
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

    blocTest<PublicChatsBloc, PublicChatsState>(
      'should nothing happen as well',
      build: () {
        whenListen(
          favoriteBloc,
          Stream.value(const FavoriteStateSuccess([
            Favorite(1, 1, 'subject'),
            Favorite(3, 3, 'subject'),
          ])),
        );
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsStateError(Rejection('reason')),
      expect: () => [],
    );
  });
}
