import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/chat_page.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_page_test.mocks.dart';

@GenerateMocks([ChatBloc])
void main() {
  late ChatBloc bloc;

  setUp(() {
    bloc = MockChatBloc();
    when(bloc.state).thenReturn(ChatState(Chat(1, 'Subject', messages: [
      Message(1, MessageType.Text, 'text 1', 'author',
          DateTime.parse('20210424'), null),
      Message(2, MessageType.Text, 'text 2', 'author',
          DateTime.parse('20210424'), null),
    ])));
    when(bloc.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('should have elements', (tester) async {
    await _fixture(tester, bloc);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);

    verify(bloc.add(const ChatEvent.refresh(1))).called(1);
  });

  testWidgets('should refresh on pulling down', (tester) async {
    await _fixture(tester, bloc);
    await tester.fling(find.text('text 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.refresh(1))).called(2);
  });

  testWidgets('should be in progress', (tester) async {
    when(bloc.state).thenReturn(const ChatState.inProgress());

    await _fixture(tester, bloc);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an error', (tester) async {
    when(bloc.state).thenReturn(ChatState.error(Rejection('reason')));

    await _fixture(tester, bloc);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should refresh while showing an error', (tester) async {
    when(bloc.state).thenReturn(ChatState.error(Rejection('reason')));

    await _fixture(tester, bloc);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(bloc.add(const ChatEvent.refresh(1))).called(2);
  });
}

Future _fixture(WidgetTester tester, ChatBloc bloc) async {
  final app = MaterialApp(
    home: ChatPage(bloc, 1),
  );
  await tester.pumpWidget(app);
}
