import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/unanswered_chats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unanswered_chats_widget_test.mocks.dart';

@GenerateMocks([UnansweredChatsBloc, IModularNavigator])
void main() {
  late UnansweredChatsBloc bloc;
  late IModularNavigator navigator;
  late Widget app;

  setUp(() {
    bloc = MockUnansweredChatsBloc();
    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;

    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    app = MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: const Material(child: UnansweredChatsWidget()),
      ),
    );

    provideDummy<UnansweredChatsState>(
        const UnansweredChatsStateInProgress([]));
  });

  testWidgets('should show a list', (tester) async {
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    expect(find.byIcon(Icons.public_rounded), findsOneWidget);
    expect(find.byIcon(Icons.lock_rounded), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should load the next page', (tester) async {
    await _fixture(bloc, tester, app, count: 12);
    expect(find.text('Chat 12'), findsNothing);
    await tester.drag(find.text('Chat 5'), const Offset(0.0, -500.0));
    await tester.pumpAndSettle();

    expect(find.text('Chat 12'), findsOneWidget);
    verify(bloc.add(const UnansweredChatsEventLoadNextPage())).called(1);
  });

  testWidgets('should delete a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.drag(find.text('Chat 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verify(
      bloc.add(
        UnansweredChatsEventDelete(
          Chat(
            2,
            ChatType.Private,
            1,
            'Chat 2',
            DateTime.parse('2021-05-01'),
            isViewedByImam: true,
          ),
        ),
      ),
    ).called(1);
  });

  testWidgets('should show a list and a progress circle', (tester) async {
    when(bloc.state).thenReturn(
      UnansweredChatsStateInProgress([
        Chat(1, ChatType.Public, 1, 'Chat 1', DateTime.parse('2021-05-01')),
        Chat(2, ChatType.Public, 1, 'Chat 2', DateTime.parse('2021-05-01')),
      ]),
    );

    await tester.pumpWidget(app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should refresh on pulling down', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.fling(find.text('Chat 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(bloc.add(const UnansweredChatsEventReload())).called(1);
  });

  testWidgets('should route to a chat', (tester) async {
    when(navigator.pushNamed('/chat/1')).thenAnswer((_) async => null);

    await _fixture(bloc, tester, app);
    await tester.tap(find.text('Chat 1'));

    verify(navigator.pushNamed('/chat/1')).called(1);
  });

  testWidgets('should show an error', (tester) async {
    await _errorFixture(bloc, tester, app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const UnansweredChatsEventReload())).called(1);
  });
}

Future _fixture(
  UnansweredChatsBloc bloc,
  WidgetTester tester,
  Widget app, {
  int count = 2,
}) async {
  when(bloc.state).thenReturn(
    UnansweredChatsStateSuccess([
      for (var i = 1; i <= count; i++)
        Chat(
          i,
          i == 1 ? ChatType.Public : ChatType.Private,
          1,
          'Chat $i',
          DateTime.parse('2021-05-01'),
          isViewedByImam: i % 2 == 0,
          isViewedByInquirer: i % 2 == 1,
        ),
    ]),
  );

  await tester.pumpWidget(app);
}

Future _errorFixture(
  UnansweredChatsBloc bloc,
  WidgetTester tester,
  Widget app,
) async {
  when(bloc.state).thenReturn(UnansweredChatsStateError(Rejection('reason')));

  await tester.pumpWidget(app);
}
