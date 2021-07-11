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
    expect(bloc.state, const UnansweredChatsState.inProgress([]));
  });

  group('Load first page:', () {
    blocTest(
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
      act: (_) => bloc.add(const UnansweredChatsEvent.reload()),
      expect: () => [
        const UnansweredChatsState.inProgress([]),
        UnansweredChatsState([
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
        when(repo.getUnanswered(0, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const UnansweredChatsEvent.reload()),
      expect: () => [
        const UnansweredChatsState.inProgress([]),
        UnansweredChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
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
      seed: () => UnansweredChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(const UnansweredChatsEvent.reload()),
      expect: () => [
        const UnansweredChatsState.inProgress([]),
        UnansweredChatsState([
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
      seed: () => UnansweredChatsState([
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
      act: (_) => bloc.add(const UnansweredChatsEvent.reload()),
      expect: () => [
        const UnansweredChatsState.inProgress([]),
        UnansweredChatsState([
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
      seed: () => UnansweredChatsState([
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
      act: (_) => bloc.add(const UnansweredChatsEvent.loadNextPage()),
      expect: () => [
        UnansweredChatsState.inProgress([
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
        UnansweredChatsState([
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
      seed: () => UnansweredChatsState.inProgress([
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
      act: (_) => bloc.add(const UnansweredChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => UnansweredChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(const UnansweredChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should be rejected on loading next page',
      build: () {
        when(repo.getUnanswered(1, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => UnansweredChatsState([
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
      act: (_) => bloc.add(const UnansweredChatsEvent.loadNextPage()),
      expect: () => [
        UnansweredChatsState.inProgress([
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
        UnansweredChatsState.error(Rejection('reason')),
      ],
    );
  });

  group('Show tab:', () {
    blocTest(
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
      act: (_) => bloc.add(const UnansweredChatsEvent.show()),
      expect: () => [
        const UnansweredChatsState.inProgress([]),
        UnansweredChatsState([
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
      seed: () => UnansweredChatsState([
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
      act: (_) => bloc.add(const UnansweredChatsEvent.show()),
      expect: () => [],
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
      seed: () => UnansweredChatsState([
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
      act: (_) => bloc.add(UnansweredChatsEvent.delete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [
        UnansweredChatsState.inProgress([
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
        UnansweredChatsState([
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
      'should not delete it',
      build: () {
        when(repo.delete(Chat(1, ChatType.Public, 1, 'subject',
                DateTime.parse('2021-05-01'))))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => UnansweredChatsState([
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
      act: (_) => bloc.add(UnansweredChatsEvent.delete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [
        UnansweredChatsState.inProgress([
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
        UnansweredChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should happen nothing',
      build: () => bloc,
      seed: () => UnansweredChatsState.inProgress([
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
      act: (_) => bloc.add(UnansweredChatsEvent.delete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [],
    );

    blocTest(
      'should happen nothing either',
      build: () => bloc,
      seed: () => UnansweredChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(UnansweredChatsEvent.delete(Chat(
          1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')))),
      expect: () => [],
    );
  });
}
