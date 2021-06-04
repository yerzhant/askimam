import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../chats/bloc/public_chats_bloc_test.mocks.dart';

void main() {
  late SearchChatsBloc bloc;
  final repo = MockChatRepository();

  setUp(() {
    bloc = SearchChatsBloc(repo);
  });

  test('Initial state', () {
    expect(bloc.state, const SearchChatsState.inProgress());
  });

  blocTest(
    'Should find chats',
    build: () {
      when(repo.find('phrase')).thenAnswer(
        (_) async => right([
          Chat(1, ChatType.Public, 1, 'subject'),
          Chat(2, ChatType.Public, 1, 'subject'),
        ]),
      );
      return bloc;
    },
    act: (_) => bloc.add(const SearchChatsEvent.find('phrase')),
    expect: () => [
      const SearchChatsState.inProgress(),
      SearchChatsState([
        Chat(1, ChatType.Public, 1, 'subject'),
        Chat(2, ChatType.Public, 1, 'subject'),
      ]),
    ],
  );

  blocTest(
    'Should reject it',
    build: () {
      when(repo.find('phrase')).thenAnswer(
        (_) async => left(Rejection('reason')),
      );
      return bloc;
    },
    act: (_) => bloc.add(const SearchChatsEvent.find('phrase')),
    expect: () => [
      const SearchChatsState.inProgress(),
      SearchChatsState.error(Rejection('reason')),
    ],
  );
}
