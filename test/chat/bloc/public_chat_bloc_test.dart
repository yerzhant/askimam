import 'package:askimam/chat/bloc/public_chat_bloc.dart';
import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'public_chat_bloc_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late PublicChatBloc bloc;
  final repo = MockChatRepository();

  setUp(() {
    bloc = PublicChatBloc(repo, 20);
  });

  test('Initial state', () {
    expect(bloc.state, PublicChatState.inProgress([]));
  });

  group('Load first page', () {
    blocTest(
      'should load public chats',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(PublicChatEvent.reload()),
      expect: () => [
        PublicChatState.inProgress([]),
        PublicChatState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
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
      act: (_) => bloc.add(PublicChatEvent.reload()),
      expect: () => [
        PublicChatState.inProgress([]),
        PublicChatState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should load public chats after an error',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      seed: () => PublicChatState.error(Rejection('reason')),
      act: (_) => bloc.add(PublicChatEvent.reload()),
      expect: () => [
        PublicChatState.inProgress([]),
        PublicChatState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ]),
      ],
    );

    blocTest(
      'should reload public chats',
      build: () {
        when(repo.getPublic(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
            Chat(4, 'subject', true),
          ]),
        );
        return bloc;
      },
      seed: () => PublicChatState([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      act: (_) => bloc.add(PublicChatEvent.reload()),
      expect: () => [
        PublicChatState.inProgress([]),
        PublicChatState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
          Chat(4, 'subject', true),
        ]),
      ],
    );
  });

  group('Load next page', () {
    blocTest(
      'should load next page',
      build: () {
        when(repo.getPublic(20, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
          ]),
        );
        return bloc;
      },
      seed: () => PublicChatState([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(PublicChatEvent.loadNextPage()),
      expect: () => [
        PublicChatState.inProgress([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
          // late testing!
          ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
        ]),
        PublicChatState([
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
      seed: () => PublicChatState.inProgress([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(PublicChatEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => PublicChatState.error(Rejection('reason')),
      act: (_) => bloc.add(PublicChatEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should be rejected on loading next page',
      build: () {
        when(repo.getPublic(20, 20))
            .thenAnswer((_) async => left(Rejection('reason')));
        return bloc;
      },
      seed: () => PublicChatState([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(PublicChatEvent.loadNextPage()),
      expect: () => [
        PublicChatState.inProgress([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
        ]),
        PublicChatState.error(Rejection('reason')),
      ],
    );
  });
  // TODO: route to messages
}
