import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/chat/domain/message.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_bloc_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late ChatBloc bloc;
  final repo = MockChatRepository();

  setUp(() {
    bloc = ChatBloc(repo);
  });

  test('Initial state', () {
    expect(bloc.state, ChatState.inProgress());
  });

  group('Get a chat:', () {
    blocTest(
      'should get it',
      build: () {
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, 'subject', false, messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
          ),
        );
        when(repo.setViewedFlag(1)).thenAnswer((_) async => none());

        return bloc;
      },
      act: (_) => bloc.add(ChatEvent.refresh(1)),
      expect: () => [
        ChatState.inProgress(),
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
        ),
      ],
      verify: (_) {
        verify(repo.setViewedFlag(1)).called(1);
      },
    );

    blocTest(
      'should not get it as was unable to set a Viewed flag',
      build: () {
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, 'subject', false, messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
          ),
        );
        when(repo.setViewedFlag(1))
            .thenAnswer((_) async => some(Rejection('reason')));

        return bloc;
      },
      act: (_) => bloc.add(ChatEvent.refresh(1)),
      expect: () => [
        ChatState.inProgress(),
        ChatState.error(Rejection('reason')),
      ],
      verify: (_) {
        verify(repo.setViewedFlag(1)).called(1);
      },
    );

    blocTest(
      'should not get it',
      build: () {
        when(repo.get(1)).thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(ChatEvent.refresh(1)),
      expect: () => [
        ChatState.inProgress(),
        ChatState.error(Rejection('reason')),
      ],
    );
  });

  group('Return to unaswered ones:', () {
    blocTest(
      'should return',
      build: () {
        when(repo.returnToUnanswered(1)).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, 'subject', false, messages: [
          Message(1, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
          Message(2, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
        ]),
      ),
      act: (_) => bloc.add(ChatEvent.returnToUnaswered()),
      expect: () => [
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          isSuccess: true,
        ),
      ],
    );

    blocTest(
      'should not return',
      build: () {
        when(repo.returnToUnanswered(1))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, 'subject', false, messages: [
          Message(1, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
          Message(2, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
        ]),
      ),
      act: (_) => bloc.add(ChatEvent.returnToUnaswered()),
      expect: () => [
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      "shouldn't even try",
      build: () => bloc,
      seed: () => ChatState.inProgress(),
      act: (_) => bloc.add(ChatEvent.returnToUnaswered()),
      expect: () => [],
    );

    blocTest(
      "shouldn't even try either",
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(ChatEvent.returnToUnaswered()),
      expect: () => [],
    );
  });

  group('Update subject:', () {
    blocTest(
      'should do it',
      build: () {
        when(repo.updateSubject(1, 'subject')).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, 'subject', false, messages: [
          Message(1, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
          Message(2, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
        ]),
      ),
      act: (_) => bloc.add(ChatEvent.updateSubject('subject')),
      expect: () => [
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          isSuccess: true,
        ),
      ],
    );

    blocTest(
      'should not do it',
      build: () {
        when(repo.updateSubject(1, 'subject'))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, 'subject', false, messages: [
          Message(1, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
          Message(2, MessageType.Text, 'text', 'author',
              DateTime.parse('20210418'), null),
        ]),
      ),
      act: (_) => bloc.add(ChatEvent.updateSubject('subject')),
      expect: () => [
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, 'subject', false, messages: [
            Message(1, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
            Message(2, MessageType.Text, 'text', 'author',
                DateTime.parse('20210418'), null),
          ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      "shouldn't even try",
      build: () => bloc,
      seed: () => ChatState.inProgress(),
      act: (_) => bloc.add(ChatEvent.updateSubject('subject')),
      expect: () => [],
    );

    blocTest(
      "shouldn't even try either",
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(ChatEvent.updateSubject('subject')),
      expect: () => [],
    );
  });
}
