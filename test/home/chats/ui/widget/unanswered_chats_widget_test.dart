import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/unanswered_chats_widget.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUnansweredChatsBloc
    extends MockBloc<UnansweredChatsEvent, UnansweredChatsState>
    implements UnansweredChatsBloc {}

void main() {
  late UnansweredChatsBloc bloc;
  late Widget app;

  setUpAll(() {
    registerFallbackValue(const UnansweredChatsState([]));
    registerFallbackValue(const UnansweredChatsEvent.reload());
  });

  setUp(() {
    bloc = MockUnansweredChatsBloc();

    app = MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => bloc,
        child: const Material(child: UnansweredChatsWidget()),
      ),
    );
  });

  testWidgets('should show a list', (tester) async {
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  // TODO: fix it
  testWidgets('should load a next page', (tester) async {
    await _fixture(bloc, tester, app, count: 12);
    expect(find.text('Chat 12'), findsNothing);
    // await tester.drag(find.text('Chat 5'), const Offset(0.0, -300.0));
    await tester.fling(find.text('Chat 5'), const Offset(0.0, -3000.0), 1000);
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();

    expect(find.text('Chat 12'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    verify(() => bloc.add(const UnansweredChatsEvent.loadNextPage())).called(1);
  }, skip: true);

  // TODO: fix it
  testWidgets('should delete a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.drag(find.text('Chat 2'), const Offset(500, 0));
    await tester.pumpAndSettle();

    verify(() => bloc.add(UnansweredChatsEvent.delete(Chat(2, 'Chat 2'))))
        .called(1);
  }, skip: true);

  testWidgets('should show a list and a progress circle', (tester) async {
    whenListen(
      bloc,
      Stream.value(const UnansweredChatsState([])),
      initialState: UnansweredChatsState.inProgress([
        Chat(1, 'Chat 1'),
        Chat(2, 'Chat 2'),
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

    verify(() => bloc.add(const UnansweredChatsEvent.reload())).called(1);
  });

  // TODO: add routing to a chat on tapping on an item
  // TODO: add favorites stuff

  testWidgets('should show an error', (tester) async {
    await _errorFixture(bloc, tester, app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(() => bloc.add(const UnansweredChatsEvent.reload())).called(1);
  });
}

Future _fixture(
  UnansweredChatsBloc bloc,
  WidgetTester tester,
  Widget app, {
  int count = 2,
}) async {
  whenListen(
    bloc,
    Stream.value(const UnansweredChatsState([])),
    initialState: UnansweredChatsState([
      for (var i = 1; i <= count; i++) Chat(i, 'Chat $i'),
    ]),
  );

  await tester.pumpWidget(app);
}

Future _errorFixture(
  UnansweredChatsBloc bloc,
  WidgetTester tester,
  Widget app,
) async {
  whenListen(
    bloc,
    Stream.value(const UnansweredChatsState([])),
    initialState: UnansweredChatsState.error(Rejection('reason')),
  );

  await tester.pumpWidget(app);
}