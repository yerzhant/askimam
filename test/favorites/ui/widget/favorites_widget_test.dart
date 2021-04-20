import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/favorites/domain/model/favorite.dart';
import 'package:askimam/favorites/ui/widget/favorites_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteBloc extends MockBloc<FavoriteEvent, FavoriteState>
    implements FavoriteBloc {}

void main() {
  late FavoriteBloc bloc;
  late Widget app;

  setUpAll(() {
    registerFallbackValue<FavoriteState>(FavoriteState([]));
    registerFallbackValue<FavoriteEvent>(FavoriteEvent.show());
  });

  setUp(() {
    bloc = MockFavoriteBloc();

    app = MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => bloc,
        child: Material(child: FavoritesWidget()),
      ),
    );
  });

  testWidgets('should show a list', (tester) async {
    whenListen(
      bloc,
      Stream.value(FavoriteState([])),
      initialState: FavoriteState([
        Favorite(1, 1, 'Chat 1'),
        Favorite(1, 1, 'Chat 2'),
      ]),
    );

    await tester.pumpWidget(app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('should invoke a refresh', (tester) async {
    whenListen(
      bloc,
      Stream.value(FavoriteState([])),
      initialState: FavoriteState([
        Favorite(1, 1, 'Chat 1'),
        Favorite(1, 1, 'Chat 2'),
      ]),
    );

    await tester.pumpWidget(app);
    await tester.fling(find.text('Chat 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(() => bloc.add(FavoriteEvent.refresh())).called(1);
  });

  testWidgets('should show a list and progress', (tester) async {
    whenListen(
      bloc,
      Stream.value(FavoriteState([])),
      initialState: FavoriteState.inProgress([
        Favorite(1, 1, 'Chat 1'),
        Favorite(1, 1, 'Chat 2'),
      ]),
    );

    await tester.pumpWidget(app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an error', (tester) async {
    whenListen(
      bloc,
      Stream.value(FavoriteState([])),
      initialState: FavoriteState.error(Rejection('reason')),
    );

    await tester.pumpWidget(app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    whenListen(
      bloc,
      Stream.value(FavoriteState([])),
      initialState: FavoriteState.error(Rejection('reason')),
    );

    await tester.pumpWidget(app);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(() => bloc.add(FavoriteEvent.refresh())).called(1);
  });
}
