import 'package:askimam/chat/bloc/my_chats_bloc.dart';
import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'my_chats_bloc_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late MyChatsBloc bloc;
  final repo = MockChatRepository();

  setUp(() {
    bloc = MyChatsBloc(repo, 20);
  });

  test('Initial state', () {
    expect(bloc.state, MyChatsState.inProgress([]));
  });

  group('Load first page', () {
    blocTest(
      'should load chats',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
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
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState.error(Rejection('reason')),
      ],
    );

    blocTest(
      'should load chats after an error',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ]),
      ],
    );

    blocTest(
      'should reload chats',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
            Chat(4, 'subject', true),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.reload()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
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
        when(repo.getMy(20, 20)).thenAnswer(
          (_) async => right([
            ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
          ]),
        );
        return bloc;
      },
      seed: () => MyChatsState([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [
        MyChatsState.inProgress([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
          // late testing!
          ...List.generate(20, (i) => Chat(i + 21, 'subject', false)),
        ]),
        MyChatsState([
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
      seed: () => MyChatsState.inProgress([
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [],
    );

    blocTest(
      'should reject to load next page if already has been rejected',
      build: () => bloc,
      seed: () => MyChatsState.error(Rejection('reason')),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
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
        ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
        Chat(19, 'subject', false),
        Chat(20, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.loadNextPage()),
      expect: () => [
        MyChatsState.inProgress([
          ...List.generate(18, (i) => Chat(i + 1, 'subject', false)),
          Chat(19, 'subject', false),
          Chat(20, 'subject', true),
        ]),
        MyChatsState.error(Rejection('reason')),
      ],
    );
  });

  group('Show tab', () {
    blocTest(
      'should load first page',
      build: () {
        when(repo.getMy(0, 20)).thenAnswer(
          (_) async => right([
            Chat(1, 'subject', false),
            Chat(2, 'subject', false),
            Chat(3, 'subject', true),
          ]),
        );
        return bloc;
      },
      act: (_) => bloc.add(MyChatsEvent.show()),
      expect: () => [
        MyChatsState.inProgress([]),
        MyChatsState([
          Chat(1, 'subject', false),
          Chat(2, 'subject', false),
          Chat(3, 'subject', true),
        ])
      ],
    );

    blocTest(
      'should not load a page',
      build: () => bloc,
      seed: () => MyChatsState([
        Chat(1, 'subject', false),
        Chat(2, 'subject', false),
        Chat(3, 'subject', true),
      ]),
      act: (_) => bloc.add(MyChatsEvent.show()),
      expect: () => [],
    );
  });
}
