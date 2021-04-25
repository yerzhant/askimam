import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_test.mocks.dart';

@GenerateMocks([
  PublicChatsBloc,
  MyChatsBloc,
  UnansweredChatsBloc,
  FavoriteBloc,
])
void main() {
  late PublicChatsBloc publicChatsBloc;
  late MyChatsBloc myChatsBloc;
  late UnansweredChatsBloc unansweredChatsBloc;
  late FavoriteBloc favoriteBloc;

  setUp(() {
    publicChatsBloc = MockPublicChatsBloc();
    myChatsBloc = MockMyChatsBloc();
    unansweredChatsBloc = MockUnansweredChatsBloc();
    favoriteBloc = MockFavoriteBloc();

    when(publicChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(myChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(unansweredChatsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(favoriteBloc.stream).thenAnswer((_) => const Stream.empty());

    when(publicChatsBloc.state).thenReturn(const PublicChatsState([]));
  });

  testWidgets('should contain contents', (tester) async {
    await _fixture(
      tester,
      publicChatsBloc,
      myChatsBloc,
      unansweredChatsBloc,
      favoriteBloc,
    );

    expect(find.text('Публичные'), findsOneWidget);
    expect(find.text('Мои'), findsOneWidget);
    expect(find.text('Избранные'), findsOneWidget);
  });
}

Future _fixture(
  WidgetTester tester,
  PublicChatsBloc publicChatsBloc,
  MyChatsBloc myChatsBloc,
  UnansweredChatsBloc unansweredChatsBloc,
  FavoriteBloc favoriteBloc,
) async {
  final app = MaterialApp(
    home: HomePage(
      publicChatsBloc: publicChatsBloc,
      myChatsBloc: myChatsBloc,
      unansweredChatsBloc: unansweredChatsBloc,
      favoriteBloc: favoriteBloc,
    ),
  );
  await tester.pumpWidget(app);
}
