import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:askimam/home/search/ui/widget/search_chats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../chats/ui/widget/public_chats_widget_test.mocks.dart';
import 'search_chats_widget_test.mocks.dart';

@GenerateMocks([SearchChatsBloc])
void main() {
  late SearchChatsBloc bloc;
  late IModularNavigator navigator;
  late Widget app;

  setUp(() {
    bloc = MockSearchChatsBloc();
    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;

    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    app = MaterialApp(
      home: BlocProvider.value(
        value: bloc,
        child: const Material(child: SearchChatsWidget()),
      ),
    );

    provideDummy<SearchChatsState>(const SearchChatsStateInProgress());
  });

  testWidgets('should show a list', (tester) async {
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should show a progress circle', (tester) async {
    when(bloc.state).thenReturn(const SearchChatsStateInProgress());

    await tester.pumpWidget(app);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should start searching', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.enterText(find.byType(TextField), 'text');
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    verify(bloc.add(const SearchChatsEventFind('text'))).called(1);
  });

  testWidgets('should not search an empty phrase', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    verifyNever(bloc.add(const SearchChatsEventFind('')));
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

  testWidgets('should retry', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.enterText(find.byType(TextField), 'text');
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const SearchChatsEventFind('text'))).called(1);
  });
}

Future _fixture(SearchChatsBloc bloc, WidgetTester tester, Widget app) async {
  when(bloc.state).thenReturn(
    SearchChatsStateSuccess([
      Chat(1, ChatType.Public, 1, 'Chat 1', DateTime.parse('2021-05-01'),
          isFavorite: false),
      Chat(2, ChatType.Public, 1, 'Chat 2', DateTime.parse('2021-05-01'),
          isFavorite: false),
    ]),
  );

  await tester.pumpWidget(app);
}

Future _errorFixture(
  SearchChatsBloc bloc,
  WidgetTester tester,
  Widget app,
) async {
  when(bloc.state).thenReturn(SearchChatsStateError(Rejection('reason')));

  await tester.pumpWidget(app);
}
