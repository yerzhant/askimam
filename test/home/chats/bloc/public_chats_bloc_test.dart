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
    mocktail.registerFallbackValue<FavoriteState>(const FavoriteState([]));
    mocktail.registerFallbackValue<FavoriteEvent>(const FavoriteEvent.show());
  });

  setUp(() {
    favoriteBloc = MockFavoriteBloc();
    bloc = PublicChatsBloc(repo, favoriteBloc, 20);
  });

  test('Initial state', () {
    expect(bloc.state, const PublicChatsState.inProgress([]));
  });

  group('Load first page:', () {
    blocTest(
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
      act: (_) => bloc.add(const PublicChatsEvent.reload()),
      expect: () => [
        const PublicChatsState.inProgress([]),
        PublicChatsState([
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
        when(repo.getPublic(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const PublicChatsEvent.reload()),
      expect: () => [
        const PublicChatsState.inProgress([]),
        PublicChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
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
      seed: () => PublicChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(const PublicChatsEvent.reload()),
      expect: () => [
        const PublicChatsState.inProgress([]),
        PublicChatsState([
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
      seed: () => PublicChatsState([
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
      act: (_) => bloc.add(const PublicChatsEvent.reload()),
      expect: () => [
        const PublicChatsState.inProgress([]),
        PublicChatsState([
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
      seed: () => PublicChatsState([
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
      act: (_) => bloc.add(const PublicChatsEvent.loadNextPage()),
      expect: () => [
        PublicChatsState.inProgress([
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
        PublicChatsState([
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

    blocTest(
      'should ignore double next page loading',
      build: () => bloc,
      seed: () => PublicChatsState.inProgress([
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
      act: (_) => bloc.add(const PublicChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => PublicChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(const PublicChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should be rejected on loading next page',
      build: () {
        when(repo.getPublic(1, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => PublicChatsState([
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
      act: (_) => bloc.add(const PublicChatsEvent.loadNextPage()),
      expect: () => [
        PublicChatsState.inProgress([
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
        PublicChatsState.error(Rejection('reason')),
      ],
    );
  });

  group('Show tab:', () {
    blocTest(
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
      act: (_) => bloc.add(const PublicChatsEvent.show()),
      expect: () => [
        const PublicChatsState.inProgress([]),
        PublicChatsState([
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
      seed: () => PublicChatsState([
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
      act: (_) => bloc.add(const PublicChatsEvent.show()),
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
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsState([
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
        PublicChatsState([
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
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsState([
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
        PublicChatsState([
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
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsState([
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
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsState.inProgress([
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
        return PublicChatsBloc(repo, favoriteBloc, 20);
      },
      seed: () => PublicChatsState.error(Rejection('reason')),
      expect: () => [],
    );
  });
}
