import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([
  PublicChatsBloc,
  MyChatsBloc,
  UnansweredChatsBloc,
  FavoriteBloc,
  AuthBloc,
  IModularNavigator,
])
void main() {
  late PublicChatsBloc publicChatsBloc;
  late MyChatsBloc myChatsBloc;
  late UnansweredChatsBloc unansweredChatsBloc;
  late FavoriteBloc favoriteBloc;
  late AuthBloc authBloc;
  late IModularNavigator navigator;

  setUp(() {
    publicChatsBloc = MockPublicChatsBloc();
    myChatsBloc = MockMyChatsBloc();
    unansweredChatsBloc = MockUnansweredChatsBloc();
    favoriteBloc = MockFavoriteBloc();
    authBloc = MockAuthBloc();
    navigator = MockIModularNavigator();

    Modular.navigatorDelegate = navigator;

    when(publicChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(myChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(unansweredChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(favoriteBloc.stream).thenAnswer((_) => const Stream.empty());
    when(authBloc.stream).thenAnswer((_) => const Stream.empty());

    when(publicChatsBloc.state).thenReturn(const PublicChatsState([]));
    when(myChatsBloc.state).thenReturn(const MyChatsState([]));
    when(unansweredChatsBloc.state).thenReturn(const UnansweredChatsState([]));
    when(favoriteBloc.state).thenReturn(const FavoriteState([]));
    when(authBloc.state).thenReturn(AuthState.authenticated(Authentication(
      '123',
      1,
      UserType.Inquirer,
    )));
  });

  testWidgets('should contain contents for an inquirer', (tester) async {
    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
    );

    expect(find.text('Новые'), findsNothing);
    expect(find.text('Публичные'), findsOneWidget);
    expect(find.text('Мои'), findsOneWidget);
    expect(find.text('Избранные'), findsOneWidget);
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
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
    );

    expect(find.text('Новые'), findsOneWidget);
  });

  testWidgets('should show new chats', (tester) async {
    when(authBloc.state).thenReturn(AuthState.authenticated(Authentication(
      '123',
      1,
      UserType.Imam,
    )));
    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
    );
    await tester.tap(find.text('Новые'));
    await tester.pumpAndSettle();

    verify(unansweredChatsBloc.add(const UnansweredChatsEvent.show()))
        .called(1);
  });

  testWidgets('should show my chats', (tester) async {
    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
    );
    await tester.tap(find.text('Мои'));
    await tester.pumpAndSettle();

    verify(myChatsBloc.add(const MyChatsEvent.show())).called(1);
  });

  testWidgets('should show public chats', (tester) async {
    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
    );
    await tester.tap(find.text('Публичные'));
    await tester.pumpAndSettle();

    verify(publicChatsBloc.add(const PublicChatsEvent.show())).called(2);
  });

  testWidgets('should show favorites', (tester) async {
    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
    );
    await tester.tap(find.text('Избранные'));
    await tester.pumpAndSettle();

    verify(favoriteBloc.add(const FavoriteEvent.show())).called(1);
  });

  testWidgets('should create a new question', (tester) async {
    when(navigator.pushNamed('/new-question')).thenAnswer((_) async => null);

    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
      authBloc,
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
        publicChatsBloc,
        myChatsBloc,
        unansweredChatsBloc,
        favoriteBloc,
        authBloc,
      );
      await tester.tap(find.byType(FloatingActionButton));
      await tester.tap(find.text('Мои'));
      await tester.tap(find.text('Избранные'));

      verify(navigator.pushNamed('/auth/login')).called(3);
    },
  );
}

Future _fixture(
  WidgetTester tester,
  PublicChatsBloc publicChatsBloc,
  MyChatsBloc myChatsBloc,
  UnansweredChatsBloc unansweredChatsBloc,
  FavoriteBloc favoriteBloc,
  AuthBloc authBloc,
) async {
  final app = MaterialApp(
    home: HomePage(
      publicChatsBloc: publicChatsBloc,
      myChatsBloc: myChatsBloc,
      unansweredChatsBloc: unansweredChatsBloc,
      favoriteBloc: favoriteBloc,
      authBloc: authBloc,
    ),
  );
  await tester.pumpWidget(app);
}
