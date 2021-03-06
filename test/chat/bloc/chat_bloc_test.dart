import 'dart:io';

import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/domain/repo/message_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_bloc_test.mocks.dart';

@GenerateMocks([
  AuthBloc,
  MyChatsBloc,
  ChatRepository,
  MessageRepository,
  UnansweredChatsBloc,
])
void main() {
  late ChatBloc bloc;
  final authBloc = MockAuthBloc();
  final repo = MockChatRepository();
  final myChatsBloc = MockMyChatsBloc();
  final messageRepo = MockMessageRepository();
  final unansweredChatsBloc = MockUnansweredChatsBloc();

  setUp(() {
    when(authBloc.state).thenReturn(AuthState.authenticated(
      Authentication('jwt', 1, UserType.Inquirer),
    ));

    bloc = ChatBloc(
      repo,
      messageRepo,
      authBloc,
      myChatsBloc,
      unansweredChatsBloc,
    );
  });

  test('Initial state', () {
    expect(bloc.state, const ChatState.inProgress());
  });

  group('Get a chat:', () {
    blocTest(
      'should get it',
      build: () {
        reset(myChatsBloc);
        reset(unansweredChatsBloc);

        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
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
      act: (_) => bloc.add(const ChatEvent.refresh(1)),
      expect: () => [
        const ChatState.inProgress(),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isSuccess: true,
        ),
      ],
      verify: (_) {
        verify(repo.setViewedFlag(1)).called(1);
        verify(myChatsBloc.add(const MyChatsEvent.reload())).called(1);
        verifyNever(
            unansweredChatsBloc.add(const UnansweredChatsEvent.reload()));
      },
    );

    blocTest(
      'should get it without updating a viewed flag - unauth',
      build: () {
        when(authBloc.state).thenReturn(const AuthState.unauthenticated());
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
                  Message(1, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                  Message(2, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                ]),
          ),
        );

        return bloc;
      },
      act: (_) => bloc.add(const ChatEvent.refresh(1)),
      expect: () => [
        const ChatState.inProgress(),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isSuccess: true,
        ),
      ],
      verify: (_) {
        verifyNever(repo.setViewedFlag(1));
      },
    );

    blocTest(
      'should get it without updating a viewed flag - not an author',
      build: () {
        when(authBloc.state).thenReturn(AuthState.authenticated(
          Authentication('jwt', 10, UserType.Inquirer),
        ));
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
                  Message(1, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                  Message(2, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                ]),
          ),
        );

        return bloc;
      },
      act: (_) => bloc.add(const ChatEvent.refresh(1)),
      expect: () => [
        const ChatState.inProgress(),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isSuccess: true,
        ),
      ],
      verify: (_) {
        verifyNever(repo.setViewedFlag(1));
      },
    );

    blocTest(
      'should get it and update a viewed flag - as it is an imam',
      build: () {
        reset(myChatsBloc);
        reset(unansweredChatsBloc);

        when(authBloc.state).thenReturn(AuthState.authenticated(
          Authentication('jwt', 10, UserType.Imam),
        ));
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
                  Message(1, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                  Message(2, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                ]),
          ),
        );

        return bloc;
      },
      act: (_) => bloc.add(const ChatEvent.refresh(1)),
      expect: () => [
        const ChatState.inProgress(),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isSuccess: true,
        ),
      ],
      verify: (_) {
        verify(repo.setViewedFlag(1)).called(1);
        verify(myChatsBloc.add(const MyChatsEvent.reload())).called(1);
        verify(unansweredChatsBloc.add(const UnansweredChatsEvent.reload()))
            .called(1);
      },
    );

    blocTest(
      'should not get it as it was not able to set a Viewed flag',
      build: () {
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
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
      act: (_) => bloc.add(const ChatEvent.refresh(1)),
      expect: () => [
        const ChatState.inProgress(),
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
      act: (_) => bloc.add(const ChatEvent.refresh(1)),
      expect: () => [
        const ChatState.inProgress(),
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
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.returnToUnaswered()),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
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
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.returnToUnaswered()),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
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
      seed: () => const ChatState.inProgress(),
      act: (_) => bloc.add(const ChatEvent.returnToUnaswered()),
      expect: () => [],
    );

    blocTest(
      "shouldn't even try either",
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(const ChatEvent.returnToUnaswered()),
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
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.updateSubject('subject')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
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
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.updateSubject('subject')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
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
      seed: () => const ChatState.inProgress(),
      act: (_) => bloc.add(const ChatEvent.updateSubject('subject')),
      expect: () => [],
    );

    blocTest(
      "shouldn't even try either",
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(const ChatEvent.updateSubject('subject')),
      expect: () => [],
    );
  });

  group('Add text:', () {
    blocTest(
      'should add it',
      build: () {
        when(messageRepo.addText(1, 'text')).thenAnswer((_) async => none());
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
                  Message(1, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                  Message(2, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                ]),
          ),
        );

        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.addText('text')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
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
      'should not add it',
      build: () {
        when(messageRepo.addText(1, 'text')).thenAnswer((_) async => none());
        when(repo.get(1)).thenAnswer(
          (_) async => left(Rejection('reason')),
        );

        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.addText('text')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      'should not add it as well',
      build: () {
        when(messageRepo.addText(1, 'text'))
            .thenAnswer((_) async => some(Rejection('reason')));

        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.addText('text')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatState.inProgress(),
      act: (_) => bloc.add(const ChatEvent.addText('text')),
      expect: () => [],
    );

    blocTest(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(const ChatEvent.addText('text')),
      expect: () => [],
    );
  });

  group('Add audio:', () {
    final file = File('audio.mp3');

    blocTest(
      'should add it',
      build: () {
        when(messageRepo.addAudio(1, file, '1:23'))
            .thenAnswer((_) async => none());
        when(repo.get(1)).thenAnswer(
          (_) async => right(
            Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
                messages: [
                  Message(1, MessageType.Text, 'text', 'author',
                      DateTime.parse('20210418'), null),
                  Message(2, MessageType.Audio, 'audio', 'imam',
                      DateTime.parse('20210418'), null,
                      audio: 'audio.mp3', duration: '1:23'),
                ]),
          ),
        );

        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(ChatEvent.addAudio(file, '1:23')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Audio, 'audio', 'imam',
                    DateTime.parse('20210418'), null,
                    audio: 'audio.mp3', duration: '1:23'),
              ]),
          isSuccess: true,
        ),
      ],
    );

    blocTest(
      'should not add it',
      build: () {
        when(messageRepo.addAudio(1, file, '1:23'))
            .thenAnswer((_) async => none());
        when(repo.get(1)).thenAnswer(
          (_) async => left(Rejection('reason')),
        );

        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(ChatEvent.addAudio(file, '1:23')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      'should not add it as well',
      build: () {
        when(messageRepo.addAudio(1, file, '1:23'))
            .thenAnswer((_) async => some(Rejection('reason')));

        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(ChatEvent.addAudio(file, '1:23')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatState.inProgress(),
      act: (_) => bloc.add(ChatEvent.addAudio(file, '1:23')),
      expect: () => [],
    );

    blocTest(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(ChatEvent.addAudio(file, '1:23')),
      expect: () => [],
    );
  });

  group('Delete a message:', () {
    blocTest(
      'should do it',
      build: () {
        when(messageRepo.delete(1, 1)).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.deleteMessage(1)),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
        ),
      ],
    );

    blocTest(
      'should not do it',
      build: () {
        when(messageRepo.delete(1, 1))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.deleteMessage(1)),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: []),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatState.inProgress(),
      act: (_) => bloc.add(const ChatEvent.deleteMessage(1)),
      expect: () => [],
    );

    blocTest(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(const ChatEvent.deleteMessage(1)),
      expect: () => [],
    );
  });

  group('Update a message:', () {
    blocTest(
      'should do it',
      build: () {
        when(messageRepo.updateText(1, 1, 'text 2'))
            .thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.updateTextMessage(1, 'text 2')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text 2', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
        ),
      ],
    );

    blocTest(
      'should not do it',
      build: () {
        when(messageRepo.updateText(1, 1, 'text 2'))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatState(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEvent.updateTextMessage(1, 'text 2')),
      expect: () => [
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatState(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatState.inProgress(),
      act: (_) => bloc.add(const ChatEvent.updateTextMessage(1, 'text 2')),
      expect: () => [],
    );

    blocTest(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatState.error(Rejection('reason')),
      act: (_) => bloc.add(const ChatEvent.updateTextMessage(1, 'text 2')),
      expect: () => [],
    );
  });
}
