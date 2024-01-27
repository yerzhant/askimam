import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/public_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'public_chats_widget_test.mocks.dart';

@GenerateMocks([
  AuthBloc,
  FavoriteBloc,
  PublicChatsBloc,
  IModularNavigator,
])
void main() {
  late AuthBloc authBloc;
  late PublicChatsBloc bloc;
  late FavoriteBloc favoriteBloc;
  late IModularNavigator navigator;
  late Widget app;

  setUp(() {
    authBloc = MockAuthBloc();
    bloc = MockPublicChatsBloc();
    favoriteBloc = MockFavoriteBloc();
    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;

    when(bloc.stream).thenAnswer((_) => const Stream.empty());
    when(authBloc.stream).thenAnswer((_) => const Stream.empty());
    when(favoriteBloc.stream).thenAnswer((_) => const Stream.empty());

    when(authBloc.state).thenReturn(const AuthStateAuthenticated(
      Authentication('123', 1, UserType.Inquirer),
    ));

    app = MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc),
          BlocProvider.value(value: authBloc),
          BlocProvider.value(value: favoriteBloc),
        ],
        child: const Material(child: PublicChatsWidget()),
      ),
    );
  });

  testWidgets('should show a list', (tester) async {
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should not contain bookmarks', (tester) async {
    when(authBloc.state).thenReturn(const AuthStateUnauthenticated());
    await _fixture(bloc, tester, app);

    expect(find.byIcon(Icons.bookmark), findsNothing);
    expect(find.byIcon(Icons.bookmark_border), findsNothing);
  });

  testWidgets('should load a next page', (tester) async {
    await _fixture(bloc, tester, app, count: 12);
    expect(find.text('Chat 12'), findsNothing);
    await tester.drag(find.text('Chat 1'), const Offset(0.0, -500.0));
    await tester.pumpAndSettle();

    expect(find.text('Chat 12'), findsOneWidget);
    verify(bloc.add(const PublicChatsEventLoadNextPage())).called(1);
  });

  testWidgets('should show a list and a progress circle', (tester) async {
    when(bloc.state).thenReturn(
      PublicChatsStateInProgress([
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

    verify(bloc.add(const PublicChatsEventReload())).called(1);
  });

  testWidgets('should route to a chat', (tester) async {
    when(navigator.pushNamed('/chat/1')).thenAnswer((_) async => null);

    await _fixture(bloc, tester, app);
    await tester.tap(find.text('Chat 1'));

    verify(navigator.pushNamed('/chat/1')).called(1);
  });

  testWidgets('should bookmark a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.byIcon(Icons.bookmark_border));

    verify(favoriteBloc.add(
      FavoriteEventAdd(
        Chat(1, ChatType.Public, 1, 'Chat 1', DateTime.parse('2021-05-01')),
      ),
    )).called(1);
  });

  testWidgets('should unbookmark a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.byIcon(Icons.bookmark));

    verify(favoriteBloc.add(const FavoriteEventDelete(2))).called(1);
  });

  testWidgets('should show an error', (tester) async {
    await _errorFixture(bloc, tester, app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const PublicChatsEventReload())).called(1);
  });
}

Future _fixture(
  PublicChatsBloc bloc,
  WidgetTester tester,
  Widget app, {
  int count = 2,
}) async {
  when(bloc.state).thenReturn(
    PublicChatsStateSuccess([
      for (var i = 1; i <= count; i++)
        Chat(
          i,
          ChatType.Public,
          1,
          'Chat $i',
          DateTime.parse('2021-05-01'),
          isFavorite: i == 2,
        ),
    ]),
  );

  await tester.pumpWidget(app);
}

Future _errorFixture(
  PublicChatsBloc bloc,
  WidgetTester tester,
  Widget app,
) async {
  when(bloc.state).thenReturn(PublicChatsStateError(Rejection('reason')));

  await tester.pumpWidget(app);
}
