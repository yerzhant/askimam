import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/chats/ui/widget/my_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/public_chats_widget.dart';
import 'package:askimam/home/chats/ui/widget/unanswered_chats_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:askimam/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../search/ui/widget/search_chats_widget_test.mocks.dart';
import 'home_page_test.mocks.dart';

@GenerateMocks([
  AuthBloc,
  MyChatsBloc,
  FavoriteBloc,
  PublicChatsBloc,
  IModularNavigator,
  UnansweredChatsBloc,
])
void main() {
  late AuthBloc authBloc;
  late MyChatsBloc myChatsBloc;
  late FavoriteBloc favoriteBloc;
  late IModularNavigator navigator;
  late SearchChatsBloc searchChatsBloc;
  late PublicChatsBloc publicChatsBloc;
  late UnansweredChatsBloc unansweredChatsBloc;

  setUp(() {
    authBloc = MockAuthBloc();
    myChatsBloc = MockMyChatsBloc();
    favoriteBloc = MockFavoriteBloc();
    searchChatsBloc = MockSearchChatsBloc();
    publicChatsBloc = MockPublicChatsBloc();
    unansweredChatsBloc = MockUnansweredChatsBloc();

    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;

    when(authBloc.stream).thenAnswer((_) => const Stream.empty());
    when(myChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(favoriteBloc.stream).thenAnswer((_) => const Stream.empty());
    when(searchChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(publicChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(unansweredChatsBloc.stream).thenAnswer((_) => const Stream.empty());

    when(myChatsBloc.state).thenReturn(const MyChatsState([]));
    when(favoriteBloc.state).thenReturn(const FavoriteState([]));
    when(searchChatsBloc.state).thenReturn(const SearchChatsState([]));
    when(publicChatsBloc.state).thenReturn(const PublicChatsState([]));
    when(unansweredChatsBloc.state).thenReturn(const UnansweredChatsState([]));
    when(authBloc.state).thenReturn(AuthState.authenticated(Authentication(
      '123',
      1,
      UserType.Inquirer,
    )));
  });

  testWidgets('should contain contents for an inquirer', (tester) async {
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    expect(find.text('Новые'), findsNothing);
    expect(find.text('Публичные'), findsOneWidget);
    expect(find.text('Мои'), findsOneWidget);
    expect(find.text('Избранные'), findsOneWidget);
    expect(find.text('Поиск'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
  });

  testWidgets('should contain contents for an imam', (tester) async {
    when(authBloc.state).thenReturn(AuthState.authenticated(Authentication(
      '123',
      1,
      UserType.Imam,
    )));

    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    expect(find.text('Новые'), findsOneWidget);
  });

  testWidgets('should load public chats on launch', (tester) async {
    when(authBloc.state).thenReturn(const AuthState.unauthenticated());

    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    expect(find.byType(PublicChatsWidget), findsOneWidget);
    verify(publicChatsBloc.add(const PublicChatsEvent.reload())).called(1);
  });

  testWidgets('should load my chats on launch', (tester) async {
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    expect(find.byType(MyChatsWidget), findsOneWidget);
    verify(myChatsBloc.add(const MyChatsEvent.reload())).called(1);
  });

  testWidgets('should load new chats on launch', (tester) async {
    when(authBloc.state).thenReturn(AuthState.authenticated(Authentication(
      '123',
      1,
      UserType.Imam,
    )));

    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    expect(find.byType(UnansweredChatsWidget), findsOneWidget);
    verify(unansweredChatsBloc.add(const UnansweredChatsEvent.reload()))
        .called(1);
  });

  testWidgets('should show new chats', (tester) async {
    when(authBloc.state).thenReturn(AuthState.authenticated(Authentication(
      '123',
      1,
      UserType.Imam,
    )));

    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );
    await tester.tap(find.text('Новые'));
    await tester.pumpAndSettle();

    verify(unansweredChatsBloc.add(const UnansweredChatsEvent.show()))
        .called(1);
  });

  testWidgets('should show my chats', (tester) async {
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );
    await tester.tap(find.text('Мои'));
    await tester.pumpAndSettle();

    verify(myChatsBloc.add(const MyChatsEvent.show())).called(1);
  });

  testWidgets('should show public chats', (tester) async {
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );
    await tester.tap(find.text('Публичные'));
    await tester.pumpAndSettle();

    verify(publicChatsBloc.add(const PublicChatsEvent.show())).called(1);
  });

  testWidgets('should show favorites', (tester) async {
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );
    await tester.tap(find.text('Избранные'));
    await tester.pumpAndSettle();

    verify(favoriteBloc.add(const FavoriteEvent.show())).called(1);
  });

  testWidgets('should show search chats', (tester) async {
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    await tester.tap(find.text('Поиск'));
  });

  testWidgets('should create a new question', (tester) async {
    when(navigator.pushNamed('/new-question')).thenAnswer((_) async => null);

    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );
    await tester.tap(find.byType(FloatingActionButton));

    verify(navigator.pushNamed('/new-question')).called(1);
  });

  testWidgets(
    'should go to login page on tapping on new question button and nav items',
    (tester) async {
      when(authBloc.state).thenReturn(const AuthState.unauthenticated());
      when(navigator.pushNamed('/auth/login')).thenAnswer((_) async => null);

      await _fixture(
        tester,
        authBloc,
        myChatsBloc,
        favoriteBloc,
        searchChatsBloc,
        publicChatsBloc,
        unansweredChatsBloc,
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.tap(find.text('Мои'));
      await tester.tap(find.text('Избранные'));

      verify(navigator.pushNamed('/auth/login')).called(3);
    },
  );

  testWidgets('should load my chats on successful logging in', (tester) async {
    when(authBloc.stream).thenAnswer((_) => Stream.value(
          AuthState.authenticated(Authentication('123', 1, UserType.Inquirer)),
        ));
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    verify(myChatsBloc.add(const MyChatsEvent.reload())).called(2);
  });

  testWidgets('should load new chats on successful logging in', (tester) async {
    when(authBloc.state).thenReturn(
      AuthState.authenticated(Authentication('123', 1, UserType.Imam)),
    );
    when(authBloc.stream).thenAnswer((_) => Stream.value(
          AuthState.authenticated(Authentication('123', 1, UserType.Imam)),
        ));
    await _fixture(
      tester,
      authBloc,
      myChatsBloc,
      favoriteBloc,
      searchChatsBloc,
      publicChatsBloc,
      unansweredChatsBloc,
    );

    verify(unansweredChatsBloc.add(const UnansweredChatsEvent.reload()))
        .called(2);
  });
}

Future _fixture(
  WidgetTester tester,
  AuthBloc authBloc,
  MyChatsBloc myChatsBloc,
  FavoriteBloc favoriteBloc,
  SearchChatsBloc searchChatsBloc,
  PublicChatsBloc publicChatsBloc,
  UnansweredChatsBloc unansweredChatsBloc,
) async {
  final app = MaterialApp(
    home: HomePage(
      authBloc: authBloc,
      myChatsBloc: myChatsBloc,
      favoriteBloc: favoriteBloc,
      searchChatsBloc: searchChatsBloc,
      publicChatsBloc: publicChatsBloc,
      unansweredChatsBloc: unansweredChatsBloc,
    ),
  );
  await tester.pumpWidget(app);
}
