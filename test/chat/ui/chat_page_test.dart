import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
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

@GenerateMocks([ChatBloc, AuthBloc])
void main() {
  late ChatBloc bloc;
  late AuthBloc authBloc;

  setUp(() {
    bloc = MockChatBloc();
    when(bloc.state).thenReturn(ChatState(Chat(1, 'Subject', messages: [
      Message(1, MessageType.Text, 'text 1', 'author',
          DateTime.parse('20210424'), null),
      Message(2, MessageType.Text, 'text 2', 'author',
          DateTime.parse('20210424'), null),
    ])));
    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    authBloc = MockAuthBloc();
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', UserType.Inquirer)));
    when(authBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('should have elements', (tester) async {
    await _fixture(tester, bloc, authBloc);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.send), findsOneWidget);
    expect(find.byIcon(Icons.assignment_return), findsNothing);

    verify(bloc.add(const ChatEvent.refresh(1))).called(1);
  });

  testWidgets('should have additinal elements for imams', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', UserType.Imam)));
    await _fixture(tester, bloc, authBloc);

    expect(find.byIcon(Icons.assignment_return), findsOneWidget);
  });

  testWidgets('should return a chat to unanswered ones', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', UserType.Imam)));
    await _fixture(tester, bloc, authBloc);
    await tester.tap(find.byIcon(Icons.assignment_return));

    verify(bloc.add(const ChatEvent.returnToUnaswered())).called(1);
  });

  testWidgets('should refresh on pulling down', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.fling(find.text('text 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.refresh(1))).called(2);
  });

  testWidgets('should delete a chat', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.drag(find.text('text 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.deleteMessage(2))).called(1);
  });

  testWidgets('should create a message', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.enterText(find.byType(TextField), 'text 3');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.addText('text 3'))).called(1);
  });

  testWidgets('should trim a message', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.enterText(find.byType(TextField), ' text 3 ');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.addText('text 3'))).called(1);
  });

  testWidgets('should not send an empty message', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.enterText(find.byType(TextField), ' ');
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    verifyNever(bloc.add(const ChatEvent.addText('')));
  });

  testWidgets('should be in progress with messages', (tester) async {
    when(bloc.state).thenReturn(ChatState(
        Chat(1, 'Subject', messages: [
          Message(1, MessageType.Text, 'text 1', 'author',
              DateTime.parse('20210424'), null),
        ]),
        isInProgress: true));

    await _fixture(tester, bloc, authBloc);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an intermediate rejection', (tester) async {
    when(bloc.stream).thenAnswer((_) => Stream.value(
        ChatState(Chat(1, 'subject'), rejection: Rejection('reason'))));

    await _fixture(tester, bloc, authBloc);
    await tester.pumpAndSettle();

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should be in progress', (tester) async {
    when(bloc.state).thenReturn(const ChatState.inProgress());

    await _fixture(tester, bloc, authBloc);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an error', (tester) async {
    when(bloc.state).thenReturn(ChatState.error(Rejection('reason')));

    await _fixture(tester, bloc, authBloc);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should refresh while showing an error', (tester) async {
    when(bloc.state).thenReturn(ChatState.error(Rejection('reason')));

    await _fixture(tester, bloc, authBloc);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(bloc.add(const ChatEvent.refresh(1))).called(2);
  });
}

Future _fixture(WidgetTester tester, ChatBloc bloc, AuthBloc authBloc) async {
  final app = MaterialApp(
    home: ChatPage(1, bloc, authBloc),
  );
  await tester.pumpWidget(app);
}
