import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_page_test.mocks.dart';

@GenerateMocks([ChatBloc])
void main() {
  final bloc = MockChatBloc();

  setUp(() {
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
}

Future _fixture(WidgetTester tester, ChatBloc bloc) async {
  final app = MaterialApp(
    home: ChatPage(bloc, 1),
  );
  await tester.pumpWidget(app);
}
