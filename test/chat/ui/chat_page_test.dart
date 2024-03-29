import 'dart:ffi';

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
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'chat_page_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ChatBloc>(),
  MockSpec<AuthBloc>(),
  MockSpec<IModularNavigator>(),
  MockSpec<FlutterSoundRecorder>(),
])
void main() {
  late MockChatBloc bloc;
  late AuthBloc authBloc;
  late FlutterSoundRecorder soundRecorder;
  final navigator = MockIModularNavigator();

  setUp(() {
    Modular.navigatorDelegate = navigator;

    PermissionHandlerPlatform.instance = _MockPermPlatform();
    soundRecorder = MockFlutterSoundRecorder();

    bloc = MockChatBloc();
    provideDummy<ChatState>(const ChatStateInProgress());
    when(bloc.state).thenReturn(ChatStateSuccess(Chat(
        1, ChatType.Public, 1, 'Subject', DateTime.parse('2021-05-01'),
        messages: [
          Message(1, MessageType.Text, 'text 1', 'author',
              DateTime.parse('20210424'), null),
          Message(2, MessageType.Text, 'text 2', 'author',
              DateTime.parse('20210424'), null),
        ])));
    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    authBloc = MockAuthBloc();
    provideDummy<AuthState>(const AuthStateInProgress());
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 1, UserType.Inquirer, 'fcm')));
    when(authBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('should have elements', (tester) async {
    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byIcon(Icons.mic_rounded), findsNothing);
    expect(find.byIcon(Icons.send_rounded), findsOneWidget);
    expect(find.byIcon(Icons.rotate_left_rounded), findsNothing);

    verify(bloc.add(const ChatEventRefresh(1))).called(1);
  });

  testWidgets('should have public elements only - unauth', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateUnauthenticated());
    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.mic_rounded), findsNothing);
    expect(find.byIcon(Icons.send_rounded), findsNothing);
    expect(find.byIcon(Icons.rotate_left_rounded), findsNothing);
  });

  testWidgets('should have public elements only - auth', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 10, UserType.Inquirer, 'fcm')));
    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('text 1'), findsOneWidget);
    expect(find.text('text 2'), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.byIcon(Icons.mic_rounded), findsNothing);
    expect(find.byIcon(Icons.send_rounded), findsNothing);
    expect(find.byIcon(Icons.rotate_left_rounded), findsNothing);
  });

  testWidgets('should have additinal elements for imams', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 2, UserType.Imam, 'fcm')));
    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.byType(MessageComposer), findsOneWidget);
    expect(find.byIcon(Icons.rotate_left_rounded), findsOneWidget);
    expect(find.byIcon(Icons.mic_rounded), findsOneWidget);
  });

  testWidgets('should start recording audio', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 2, UserType.Imam, 'fcm')));
    when(soundRecorder.openRecorder()).thenAnswer((_) async => soundRecorder);
    when(soundRecorder.startRecorder()).thenAnswer((_) async => Void);
    when(soundRecorder.onProgress).thenReturn(null);

    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.tap(find.byIcon(Icons.mic_rounded));
    await tester.pump();

    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.text('00:00'), findsOneWidget);
    expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
  });

  testWidgets('should send audio', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 2, UserType.Imam, 'fcm')));
    when(soundRecorder.openRecorder()).thenAnswer((_) async => soundRecorder);
    when(soundRecorder.startRecorder()).thenAnswer((_) async => Void);
    when(soundRecorder.stopRecorder()).thenAnswer((_) async => 'audio.mp3');
    when(soundRecorder.onProgress).thenReturn(null);

    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.tap(find.byIcon(Icons.mic_rounded));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.send_rounded));
    await tester.pump();

    final event = verify(bloc.add(captureAny))
        .captured
        .firstWhere((e) => e is ChatEventAddAudio) as ChatEventAddAudio;
    expect(event.duration, '00:00');
    expect(event.file.path, 'audio.mp3');
  });

  testWidgets('should return a chat to unanswered ones', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 2, UserType.Imam, 'fcm')));
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.tap(find.byIcon(Icons.rotate_left_rounded));

    verify(bloc.add(const ChatEventReturnToUnaswered())).called(1);
    verify(navigator.pop()).called(1);
  });

  testWidgets('should refresh on pulling down', (tester) async {
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.fling(find.text('text 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEventRefresh(1))).called(2);
  });

  testWidgets('should delete a chat', (tester) async {
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.drag(find.text('text 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEventDeleteMessage(2))).called(1);
  }, skip: true);

  testWidgets('should not allow to delete a chat', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 2, UserType.Inquirer, 'fcm')));
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.drag(find.text('text 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verifyNever(bloc.add(const ChatEventDeleteMessage(2)));
  });

  testWidgets('should allow to delete a chat to an imam', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
        Authentication('jwt', 20, UserType.Imam, 'fcm')));
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.drag(find.text('text 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEventDeleteMessage(2))).called(1);
  }, skip: true);

  testWidgets('should create a message', (tester) async {
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.enterText(find.byType(TextField), 'text 3');
    await tester.tap(find.byIcon(Icons.send_rounded).first);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEventAddText('text 3'))).called(1);
  });

  testWidgets('should trim a message', (tester) async {
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.enterText(find.byType(TextField), ' text 3 ');
    await tester.tap(find.byIcon(Icons.send_rounded).first);
    await tester.pumpAndSettle();

    verify(bloc.add(const ChatEventAddText('text 3'))).called(1);
  });

  testWidgets('should not send an empty message', (tester) async {
    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.enterText(find.byType(TextField), ' ');
    await tester.tap(find.byIcon(Icons.send_rounded).first);
    await tester.pumpAndSettle();

    verifyNever(bloc.add(const ChatEventAddText('')));
  });

  testWidgets('should be in progress with messages', (tester) async {
    when(bloc.state).thenReturn(ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'Subject', DateTime.parse('2021-05-01'),
            messages: [
              Message(1, MessageType.Text, 'text 1', 'author',
                  DateTime.parse('20210424'), null),
            ]),
        isInProgress: true));

    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an intermediate rejection', (tester) async {
    when(bloc.stream).thenAnswer((_) => Stream.value(ChatStateSuccess(
        Chat(1, ChatType.Public, 1, 'subject', DateTime.parse('2021-05-01')),
        rejection: Rejection('reason'))));

    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.pumpAndSettle();

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should be in progress', (tester) async {
    when(bloc.state).thenReturn(const ChatStateInProgress());

    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an error', (tester) async {
    when(bloc.state).thenReturn(ChatStateError(Rejection('reason')));

    await _fixture(tester, bloc, authBloc, soundRecorder);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should refresh while showing an error', (tester) async {
    when(bloc.state).thenReturn(ChatStateError(Rejection('reason')));

    await _fixture(tester, bloc, authBloc, soundRecorder);
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const ChatEventRefresh(1))).called(2);
  });
}

Future _fixture(
  WidgetTester tester,
  ChatBloc bloc,
  AuthBloc authBloc,
  FlutterSoundRecorder soundRecorder,
) async {
  final app = MaterialApp(
    home: ChatPage(1, bloc, authBloc, soundRecorder),
  );
  await tester.pumpWidget(app);
}

class _MockPermPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PermissionHandlerPlatform {
  @override
  Future<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissions) {
    return Future.value({Permission.microphone: PermissionStatus.granted});
  }
}
