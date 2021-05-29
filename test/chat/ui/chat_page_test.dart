import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/bloc/chat_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/model/message.dart';
import 'package:askimam/chat/ui/chat_page.dart';
import 'package:askimam/chat/ui/widget/message_composer.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_page_test.mocks.dart';

@GenerateMocks([ChatBloc, AuthBloc, IModularNavigator])
void main() {
  late ChatBloc bloc;
  late AuthBloc authBloc;
  final navigator = MockIModularNavigator();

  setUp(() {
    Modular.navigatorDelegate = navigator;

    bloc = MockChatBloc();
    when(bloc.state)
        .thenReturn(ChatState(Chat(1, ChatType.Public, 1, 'Subject', messages: [
      Message(1, MessageType.Text, 'text 1', 'author',
          DateTime.parse('20210424'), null),
      Message(2, MessageType.Text, 'text 2', 'author',
          DateTime.parse('20210424'), null),
    ])));
    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    authBloc = MockAuthBloc();
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 1, UserType.Inquirer)));
    when(authBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('should have elements', (tester) async {
    await _fixture(tester, bloc, authBloc);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsNothing);
    expect(find.byIcon(Icons.send), findsNWidgets(2));
    expect(find.byIcon(Icons.rotate_left), findsNothing);

    verify(bloc.add(const ChatEvent.refresh(1))).called(1);
  });

  testWidgets('should have public elements only - unauth', (tester) async {
    when(authBloc.state).thenReturn(const AuthState.unauthenticated());
    await _fixture(tester, bloc, authBloc);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.mic), findsNothing);
    expect(find.byIcon(Icons.send), findsNothing);
    expect(find.byIcon(Icons.rotate_left), findsNothing);
  });

  testWidgets('should have public elements only - auth', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 10, UserType.Inquirer)));
    await _fixture(tester, bloc, authBloc);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.mic), findsNothing);
    expect(find.byIcon(Icons.send), findsNothing);
    expect(find.byIcon(Icons.rotate_left), findsNothing);
  });

  testWidgets('should have additinal elements for imams', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 2, UserType.Imam)));
    await _fixture(tester, bloc, authBloc);

    expect(find.byType(MessageComposer), findsOneWidget);
    expect(find.byIcon(Icons.rotate_left), findsOneWidget);
    expect(find.byIcon(Icons.mic), findsOneWidget);
  });

  testWidgets('should start recording audio', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 2, UserType.Imam)));
    await _fixture(tester, bloc, authBloc);
    await tester.tap(find.byIcon(Icons.mic));
    await tester.pump();

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text('0:00'), findsOneWidget);
    expect(find.byIcon(Icons.cancel), findsOneWidget);
  });

  testWidgets('should send audio', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 2, UserType.Imam)));
    await _fixture(tester, bloc, authBloc);
    await tester.tap(find.byIcon(Icons.mic));
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.send).last, warnIfMissed: false);
    await tester.pumpAndSettle();

    // verify(bloc.add(ChatEvent.addAudio(any, any))).called(1);
  });

  testWidgets('should return a chat to unanswered ones', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 2, UserType.Imam)));
    await _fixture(tester, bloc, authBloc);
    await tester.tap(find.byIcon(Icons.rotate_left));

    verify(bloc.add(const ChatEvent.returnToUnaswered())).called(1);
    verify(navigator.pop()).called(1);
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

  testWidgets('should not allow to delete a chat', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 2, UserType.Inquirer)));
    await _fixture(tester, bloc, authBloc);
    await tester.drag(find.text('text 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verifyNever(bloc.add(const ChatEvent.deleteMessage(2)));
  });

  testWidgets('should allow to delete a chat to an imam', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 20, UserType.Imam)));
    await _fixture(tester, bloc, authBloc);
    await tester.drag(find.text('text 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.deleteMessage(2))).called(1);
  });

  testWidgets('should create a message', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.enterText(find.byType(TextField), 'text 3');
    await tester.tap(find.byIcon(Icons.send).first);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.addText('text 3'))).called(1);
  });

  testWidgets('should trim a message', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.enterText(find.byType(TextField), ' text 3 ');
    await tester.tap(find.byIcon(Icons.send).first);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEvent.addText('text 3'))).called(1);
  });

  testWidgets('should not send an empty message', (tester) async {
    await _fixture(tester, bloc, authBloc);
    await tester.enterText(find.byType(TextField), ' ');
    await tester.tap(find.byIcon(Icons.send).first);
    await tester.pumpAndSettle();

    verifyNever(bloc.add(const ChatEvent.addText('')));
  });

  testWidgets('should be in progress with messages', (tester) async {
    when(bloc.state).thenReturn(ChatState(
        Chat(1, ChatType.Public, 1, 'Subject', messages: [
          Message(1, MessageType.Text, 'text 1', 'author',
              DateTime.parse('20210424'), null),
        ]),
        isInProgress: true));

    await _fixture(tester, bloc, authBloc);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an intermediate rejection', (tester) async {
    when(bloc.stream).thenAnswer((_) => Stream.value(ChatState(
        Chat(1, ChatType.Public, 1, 'subject'),
        rejection: Rejection('reason'))));

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
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const ChatEvent.refresh(1))).called(2);
  });
}

Future _fixture(WidgetTester tester, ChatBloc bloc, AuthBloc authBloc) async {
  final app = MaterialApp(
    home: ChatPage(1, bloc, authBloc),
  );
  await tester.pumpWidget(app);
}
