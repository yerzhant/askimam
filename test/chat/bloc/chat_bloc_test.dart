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
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
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
    expect(bloc.state, const ChatStateInProgress());
  });

  group('Get a chat:', () {
    blocTest<ChatBloc, ChatState>(
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
      act: (_) => bloc.add(const ChatEventRefresh(1)),
      expect: () => [
        const ChatStateInProgress(),
        ChatStateSuccess(
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
        verify(myChatsBloc.add(const MyChatsEventReload())).called(1);
        verifyNever(
            unansweredChatsBloc.add(const UnansweredChatsEventReload()));
      },
    );

    blocTest<ChatBloc, ChatState>(
      'should get it without updating a viewed flag - unauth',
      build: () {
        when(authBloc.state).thenReturn(const AuthStateUnauthenticated());
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
      act: (_) => bloc.add(const ChatEventRefresh(1)),
      expect: () => [
        const ChatStateInProgress(),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should get it without updating a viewed flag - not an author',
      build: () {
        when(authBloc.state).thenReturn(const AuthStateAuthenticated(
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
      act: (_) => bloc.add(const ChatEventRefresh(1)),
      expect: () => [
        const ChatStateInProgress(),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should get it and update a viewed flag - as it is an imam',
      build: () {
        reset(myChatsBloc);
        reset(unansweredChatsBloc);

        when(authBloc.state).thenReturn(const AuthStateAuthenticated(
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
      act: (_) => bloc.add(const ChatEventRefresh(1)),
      expect: () => [
        const ChatStateInProgress(),
        ChatStateSuccess(
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
        verify(myChatsBloc.add(const MyChatsEventReload())).called(1);
        verify(unansweredChatsBloc.add(const UnansweredChatsEventReload()))
            .called(1);
      },
    );

    blocTest<ChatBloc, ChatState>(
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
      act: (_) => bloc.add(const ChatEventRefresh(1)),
      expect: () => [
        const ChatStateInProgress(),
        ChatStateError(Rejection('reason')),
      ],
      verify: (_) {
        verify(repo.setViewedFlag(1)).called(1);
      },
    );

    blocTest<ChatBloc, ChatState>(
      'should not get it',
      build: () {
        when(repo.get(1)).thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      act: (_) => bloc.add(const ChatEventRefresh(1)),
      expect: () => [
        const ChatStateInProgress(),
        ChatStateError(Rejection('reason')),
      ],
    );
  });

  group('Return to unaswered ones:', () {
    blocTest<ChatBloc, ChatState>(
      'should return',
      build: () {
        when(repo.returnToUnanswered(1)).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventReturnToUnaswered()),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should not return',
      build: () {
        when(repo.returnToUnanswered(1))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventReturnToUnaswered()),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      "shouldn't even try",
      build: () => bloc,
      seed: () => const ChatStateInProgress(),
      act: (_) => bloc.add(const ChatEventReturnToUnaswered()),
      expect: () => [],
    );

    blocTest<ChatBloc, ChatState>(
      "shouldn't even try either",
      build: () => bloc,
      seed: () => ChatStateError(Rejection('reason')),
      act: (_) => bloc.add(const ChatEventReturnToUnaswered()),
      expect: () => [],
    );
  });

  group('Update subject:', () {
    blocTest<ChatBloc, ChatState>(
      'should do it',
      build: () {
        when(repo.updateSubject(1, 'subject')).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventUpdateSubject('subject')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should not do it',
      build: () {
        when(repo.updateSubject(1, 'subject'))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventUpdateSubject('subject')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      "shouldn't even try",
      build: () => bloc,
      seed: () => const ChatStateInProgress(),
      act: (_) => bloc.add(const ChatEventUpdateSubject('subject')),
      expect: () => [],
    );

    blocTest<ChatBloc, ChatState>(
      "shouldn't even try either",
      build: () => bloc,
      seed: () => ChatStateError(Rejection('reason')),
      act: (_) => bloc.add(const ChatEventUpdateSubject('subject')),
      expect: () => [],
    );
  });

  group('Add text:', () {
    blocTest<ChatBloc, ChatState>(
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
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventAddText('text')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should not add it',
      build: () {
        when(messageRepo.addText(1, 'text')).thenAnswer((_) async => none());
        when(repo.get(1)).thenAnswer(
          (_) async => left(Rejection('reason')),
        );

        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventAddText('text')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not add it as well',
      build: () {
        when(messageRepo.addText(1, 'text'))
            .thenAnswer((_) async => some(Rejection('reason')));

        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventAddText('text')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatStateInProgress(),
      act: (_) => bloc.add(const ChatEventAddText('text')),
      expect: () => [],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatStateError(Rejection('reason')),
      act: (_) => bloc.add(const ChatEventAddText('text')),
      expect: () => [],
    );
  });

  group('Add audio:', () {
    final file = File('audio.mp3');

    blocTest<ChatBloc, ChatState>(
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
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(ChatEventAddAudio(file, '1:23')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should not add it',
      build: () {
        when(messageRepo.addAudio(1, file, '1:23'))
            .thenAnswer((_) async => none());
        when(repo.get(1)).thenAnswer(
          (_) async => left(Rejection('reason')),
        );

        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(ChatEventAddAudio(file, '1:23')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not add it as well',
      build: () {
        when(messageRepo.addAudio(1, file, '1:23'))
            .thenAnswer((_) async => some(Rejection('reason')));

        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(ChatEventAddAudio(file, '1:23')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatStateInProgress(),
      act: (_) => bloc.add(ChatEventAddAudio(file, '1:23')),
      expect: () => [],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatStateError(Rejection('reason')),
      act: (_) => bloc.add(ChatEventAddAudio(file, '1:23')),
      expect: () => [],
    );
  });

  group('Delete a message:', () {
    blocTest<ChatBloc, ChatState>(
      'should do it',
      build: () {
        when(messageRepo.delete(1, 1)).thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventDeleteMessage(1)),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not do it',
      build: () {
        when(messageRepo.delete(1, 1))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventDeleteMessage(1)),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: []),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatStateInProgress(),
      act: (_) => bloc.add(const ChatEventDeleteMessage(1)),
      expect: () => [],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatStateError(Rejection('reason')),
      act: (_) => bloc.add(const ChatEventDeleteMessage(1)),
      expect: () => [],
    );
  });

  group('Update a message:', () {
    blocTest<ChatBloc, ChatState>(
      'should do it',
      build: () {
        when(messageRepo.updateText(1, 1, 'text 2'))
            .thenAnswer((_) async => none());
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
              Message(2, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventUpdateTextMessage(1, 'text 2')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
                Message(2, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
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

    blocTest<ChatBloc, ChatState>(
      'should not do it',
      build: () {
        when(messageRepo.updateText(1, 1, 'text 2'))
            .thenAnswer((_) async => some(Rejection('reason')));
        return bloc;
      },
      seed: () => ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text', 'author',
                  DateTime.parse('20210418'), null),
            ]),
      ),
      act: (_) => bloc.add(const ChatEventUpdateTextMessage(1, 'text 2')),
      expect: () => [
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          isInProgress: true,
        ),
        ChatStateSuccess(
          Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01'),
              messages: [
                Message(1, MessageType.Text, 'text', 'author',
                    DateTime.parse('20210418'), null),
              ]),
          rejection: Rejection('reason'),
        ),
      ],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to',
      build: () => bloc,
      seed: () => const ChatStateInProgress(),
      act: (_) => bloc.add(const ChatEventUpdateTextMessage(1, 'text 2')),
      expect: () => [],
    );

    blocTest<ChatBloc, ChatState>(
      'should not even try to either',
      build: () => bloc,
      seed: () => ChatStateError(Rejection('reason')),
      act: (_) => bloc.add(const ChatEventUpdateTextMessage(1, 'text 2')),
      expect: () => [],
    );
  });
}
