import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unanswered_chats_bloc_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late UnansweredChatsBloc bloc;
  final repo = MockChatRepository();

  setUp(() {
    bloc = UnansweredChatsBloc(repo, 20);
  });

  test('Initial state', () {
    expect(bloc.state, const UnansweredChatsStateInProgress([]));
  });

  group('Load first page:', () {
    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should load chats',
      build: () {
        when(repo.getUnanswered(0, 20)).thenAnswer(
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
      act: (_) => bloc.add(const UnansweredChatsEventReload()),
      expect: () => [
        const UnansweredChatsStateInProgress([]),
        UnansweredChatsStateSuccess([
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

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should be rejected',
      build: () {
        when(repo.getUnanswered(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const UnansweredChatsEventReload()),
      expect: () => [
        const UnansweredChatsStateInProgress([]),
        UnansweredChatsStateError(Rejection('reason')),
      ],
    );

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should load chats after an error',
      build: () {
        when(repo.getUnanswered(0, 20)).thenAnswer(
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
      seed: () => UnansweredChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(const UnansweredChatsEventReload()),
      expect: () => [
        const UnansweredChatsStateInProgress([]),
        UnansweredChatsStateSuccess([
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

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should reload chats',
      build: () {
        when(repo.getUnanswered(0, 20)).thenAnswer(
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
      seed: () => UnansweredChatsStateSuccess([
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
      act: (_) => bloc.add(const UnansweredChatsEventReload()),
      expect: () => [
        const UnansweredChatsStateInProgress([]),
        UnansweredChatsStateSuccess([
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
    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should load next page',
      build: () {
        when(repo.getUnanswered(1, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(
                20,
                (i) => Chat(i + 21, ChatType.Public, 1, 'subject',
                    DateTime.parse('2021-05-01'))),
          ]),
        );
        return bloc;
      },
      seed: () => UnansweredChatsStateSuccess([
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
      act: (_) => bloc.add(const UnansweredChatsEventLoadNextPage()),
      expect: () => [
        UnansweredChatsStateInProgress([
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
        UnansweredChatsStateSuccess([
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

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should ignore double next page loading',
      build: () => bloc,
      seed: () => UnansweredChatsStateInProgress([
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
      act: (_) => bloc.add(const UnansweredChatsEventLoadNextPage()),
      expect: () => [],
    );

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => UnansweredChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(const UnansweredChatsEventLoadNextPage()),
      expect: () => [],
    );

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should be rejected on loading next page',
      build: () {
        when(repo.getUnanswered(1, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => UnansweredChatsStateSuccess([
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
      act: (_) => bloc.add(const UnansweredChatsEventLoadNextPage()),
      expect: () => [
        UnansweredChatsStateInProgress([
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
        UnansweredChatsStateError(Rejection('reason')),
      ],
    );
  });

  group('Show tab:', () {
    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should load first page',
      build: () {
        when(repo.getUnanswered(0, 20)).thenAnswer(
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
      act: (_) => bloc.add(const UnansweredChatsEventShow()),
      expect: () => [
        const UnansweredChatsStateInProgress([]),
        UnansweredChatsStateSuccess([
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

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should not load a page',
      build: () => bloc,
      seed: () => UnansweredChatsStateSuccess([
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
      act: (_) => bloc.add(const UnansweredChatsEventShow()),
      expect: () => [],
    );
  });

  group('Delete a chat:', () {
    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => UnansweredChatsStateSuccess([
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
      act: (_) => bloc.add(UnansweredChatsEventDelete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [
        UnansweredChatsStateInProgress([
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
        UnansweredChatsStateSuccess([
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

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should not delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => UnansweredChatsStateSuccess([
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
      act: (_) => bloc.add(UnansweredChatsEventDelete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [
        UnansweredChatsStateInProgress([
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
        UnansweredChatsStateError(Rejection('reason')),
      ],
    );

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should happen nothing',
      build: () => bloc,
      seed: () => UnansweredChatsStateInProgress([
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
      act: (_) => bloc.add(UnansweredChatsEventDelete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [],
    );

    blocTest<UnansweredChatsBloc, UnansweredChatsState>(
      'should happen nothing either',
      build: () => bloc,
      seed: () => UnansweredChatsStateError(Rejection('reason')),
      act: (_) => bloc.add(UnansweredChatsEventDelete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [],
    );
  });
}
