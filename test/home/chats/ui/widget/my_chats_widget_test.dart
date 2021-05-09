import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/my_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'my_chats_widget_test.mocks.dart';

@GenerateMocks([
  AuthBloc,
  MyChatsBloc,
  FavoriteBloc,
  IModularNavigator,
])
void main() {
  late Widget app;
  late MyChatsBloc bloc;
  late FavoriteBloc favoriteBloc;
  late IModularNavigator navigator;
  final authBloc = MockAuthBloc();

  setUp(() {
    bloc = MockMyChatsBloc();
    favoriteBloc = MockFavoriteBloc();
    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;

    when(bloc.stream).thenAnswer((_) => const Stream.empty());
    when(authBloc.stream).thenAnswer((_) => const Stream.empty());
    when(favoriteBloc.stream).thenAnswer((_) => const Stream.empty());
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 1, UserType.Inquirer)));

    app = BlocProvider.value(
      value: bloc,
      child: BlocProvider.value(
        value: favoriteBloc,
        child: MaterialApp(home: Scaffold(body: MyChatsWidget(authBloc))),
      ),
    );
  });

  testWidgets('should show a list of an inquirer', (tester) async {
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byIcon(Icons.public_rounded), findsOneWidget);
    expect(find.byIcon(Icons.lock_rounded), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(
      find.ancestor(
          of: find.text('Есть новое сообщение'),
          matching: find.ancestor(
            of: find.text('Chat 2'),
            matching: find.byType(ListTile),
          )),
      findsOneWidget,
    );
    expect(
      find.ancestor(
          of: find.byIcon(Icons.check_rounded),
          matching: find.ancestor(
            of: find.text('Chat 2'),
            matching: find.byType(ListTile),
          )),
      findsOneWidget,
    );
  });

  testWidgets('should show a list of an imam', (tester) async {
    when(authBloc.state).thenReturn(
        AuthState.authenticated(Authentication('jwt', 1, UserType.Imam)));
    await _fixture(bloc, tester, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byIcon(Icons.public_rounded), findsOneWidget);
    expect(find.byIcon(Icons.lock_rounded), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    expect(
      find.ancestor(
          of: find.text('Есть новое сообщение'),
          matching: find.ancestor(
            of: find.text('Chat 1'),
            matching: find.byType(ListTile),
          )),
      findsOneWidget,
    );
    expect(
      find.ancestor(
          of: find.byIcon(Icons.check_rounded),
          matching: find.ancestor(
            of: find.text('Chat 1'),
            matching: find.byType(ListTile),
          )),
      findsOneWidget,
    );
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

    verify(bloc.add(
      MyChatsEvent.delete(
        Chat(2, ChatType.Private, 1, 'Chat 2',
            isFavorite: true, isViewedByImam: true),
      ),
    )).called(1);
  });

  testWidgets('should show a list and a progress circle', (tester) async {
    when(bloc.state).thenReturn(MyChatsState.inProgress([
      Chat(1, ChatType.Public, 1, 'Chat 1'),
      Chat(2, ChatType.Private, 1, 'Chat 2'),
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

  testWidgets('should route to a chat', (tester) async {
    when(navigator.pushNamed('/chat/1')).thenAnswer((_) async => null);

    await _fixture(bloc, tester, app);
    await tester.tap(find.text('Chat 1'));

    verify(navigator.pushNamed('/chat/1')).called(1);
  });

  testWidgets('should bookmark a chat', (tester) async {
    await _fixture(bloc, tester, app);
    await tester.tap(find.byIcon(Icons.bookmark_border));

    verify(
      favoriteBloc.add(
        FavoriteEvent.add(
          Chat(1, ChatType.Public, 1, 'Chat 1', isViewedByInquirer: true),
        ),
      ),
    ).called(1);
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
    await tester.tap(find.text('ПОВТОРИТЬ'));

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
    for (var i = 1; i <= count; i++)
      Chat(
        i,
        i == 1 ? ChatType.Public : ChatType.Private,
        1,
        'Chat $i',
        isFavorite: i == 2,
        isViewedByImam: i % 2 == 0,
        isViewedByInquirer: i % 2 == 1,
      ),
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
