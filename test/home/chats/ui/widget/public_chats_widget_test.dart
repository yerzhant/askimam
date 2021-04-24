import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/public_chats_widget.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPublicChatsBloc extends MockBloc<PublicChatsEvent, PublicChatsState>
    implements PublicChatsBloc {}

void main() {
  late PublicChatsBloc bloc;
  late Widget app;

  setUpAll(() {
    registerFallbackValue(const PublicChatsState([]));
    registerFallbackValue(const PublicChatsEvent.reload());
  });

  setUp(() {
    bloc = MockPublicChatsBloc();

    app = MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => bloc,
        child: const Material(child: PublicChatsWidget()),
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
    await tester.drag(find.text('Chat 1'), const Offset(0.0, -300.0));
    await tester.pump();

    expect(find.text('Chat 12'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    verify(() => bloc.add(const PublicChatsEvent.loadNextPage())).called(1);
  }, skip: true);

  testWidgets('should show a list and a progress circle', (tester) async {
    whenListen(
      bloc,
      Stream.value(const PublicChatsState([])),
      initialState: PublicChatsState.inProgress([
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

    verify(() => bloc.add(const PublicChatsEvent.reload())).called(1);
  });

  // TODO: add routing to a chat on tapping on an item
  // TODO: add Add to/Remove from favorites + Show a favorite icon

  testWidgets('should show an error', (tester) async {
    await _errorFixture(bloc, tester, app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(() => bloc.add(const PublicChatsEvent.reload())).called(1);
  });
}

Future _fixture(
  PublicChatsBloc bloc,
  WidgetTester tester,
  Widget app, {
  int count = 2,
}) async {
  whenListen(
    bloc,
    Stream.value(const PublicChatsState([])),
    initialState: PublicChatsState([
      for (var i = 1; i <= count; i++) Chat(i, 'Chat $i'),
    ]),
  );

  await tester.pumpWidget(app);
}

Future _errorFixture(
  PublicChatsBloc bloc,
  WidgetTester tester,
  Widget app,
) async {
  whenListen(
    bloc,
    Stream.value(const PublicChatsState([])),
    initialState: PublicChatsState.error(Rejection('reason')),
  );

  await tester.pumpWidget(app);
}
