import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/my_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/src/core/interfaces/modular_navigator_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'my_chats_widget_test.mocks.dart';

@GenerateMocks([MyChatsBloc, FavoriteBloc, IModularNavigator])
void main() {
  late MyChatsBloc bloc;
  late FavoriteBloc favoriteBloc;
  late IModularNavigator navigator;
  late Widget app;

  setUp(() {
    bloc = MockMyChatsBloc();
    favoriteBloc = MockFavoriteBloc();
    navigator = MockIModularNavigator();
    // Modular.navigatorDelegate = navigator;

    when(bloc.stream).thenAnswer((_) => const Stream.empty());
    when(favoriteBloc.stream).thenAnswer((_) => const Stream.empty());

    app = BlocProvider.value(
      value: bloc,
      child: BlocProvider.value(
        value: favoriteBloc,
        child: const MaterialApp(home: Scaffold(body: MyChatsWidget())),
      ),
    );
  });

  testWidgets('should show a list', (tester) async {
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should load the next page', (tester) async {
    await _fixture(bloc, tester, app, count: 12);
    expect(find.text('Chat 12'), findsNothing);
    await tester.fling(find.text('Chat 5'), const Offset(0.0, -300.0), 1000);
    await tester.pumpAndSettle();

    expect(find.text('Chat 12'), findsOneWidget);
    verify(bloc.add(const MyChatsEvent.loadNextPage())).called(1);
  });

  testWidgets('should delete a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.drag(find.text('Chat 2'), const Offset(5000, 0));
    await tester.pumpAndSettle();

    verify(
      bloc.add(MyChatsEvent.delete(Chat(2, 1, 'Chat 2', isFavorite: true))),
    ).called(1);
  });

  testWidgets('should show a list and a progress circle', (tester) async {
    when(bloc.state).thenReturn(MyChatsState.inProgress([
      Chat(1, 1, 'Chat 1'),
      Chat(2, 1, 'Chat 2'),
    ]));

    await tester.pumpWidget(app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should refresh on pulling down', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.fling(find.text('Chat 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(bloc.add(const MyChatsEvent.reload())).called(1);
  });

  // TODO: add routing to a chat on tapping on an item
  testWidgets('should route to a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.text('Chat 1'));
    // await tester.pumpAndSettle();

    verify(navigator.navigate('/chat/1')).called(1);
  }, skip: true); // TODO: waiting for a modular to fix navigator mocking

  testWidgets('should bookmark a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.byIcon(Icons.bookmark_border));

    verify(favoriteBloc.add(FavoriteEvent.add(Chat(1, 1, 'Chat 1')))).called(1);
  });

  testWidgets('should unbookmark a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.byIcon(Icons.bookmark));

    verify(favoriteBloc.add(const FavoriteEvent.delete(2))).called(1);
  });

  testWidgets('should show an error', (tester) async {
    await _errorFixture(bloc, tester, app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(bloc.add(const MyChatsEvent.reload())).called(1);
  });
}

Future _fixture(
  MyChatsBloc bloc,
  WidgetTester tester,
  Widget app, {
  int count = 2,
}) async {
  when(bloc.state).thenReturn(MyChatsState([
    for (var i = 1; i <= count; i++) Chat(i, 1, 'Chat $i', isFavorite: i == 2),
  ]));

  await tester.pumpWidget(app);
}

Future _errorFixture(
  MyChatsBloc bloc,
  WidgetTester tester,
  Widget app,
) async {
  when(bloc.state).thenReturn(MyChatsState.error(Rejection('reason')));

  await tester.pumpWidget(app);
}
