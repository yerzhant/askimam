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
    registerFallbackValue(const FavoriteState([]));
    registerFallbackValue(const FavoriteEvent.show());
  });

  setUp(() {
    bloc = MockFavoriteBloc();

    app = MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => bloc,
        child: const Material(child: FavoritesWidget()),
      ),
    );
  });

  testWidgets('should show a list', (tester) async {
    await _standartFixture(tester, bloc, app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  // TODO: add routing to a chat by tapping on an item

  testWidgets('should invoke a refresh on pulling down', (tester) async {
    await _standartFixture(tester, bloc, app);
    await tester.fling(find.text('Chat 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(() => bloc.add(const FavoriteEvent.refresh())).called(1);
  });

  testWidgets('should delete an item', (tester) async {
    await _standartFixture(tester, bloc, app);
    await tester.drag(find.text('Chat 1'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    verify(() => bloc.add(FavoriteEvent.delete(Favorite(1, 1, 'Chat 1'))))
        .called(1);
  }, skip: true); // TODO: find out why it does not get dismissed

  testWidgets('should show a list and progress', (tester) async {
    whenListen(
      bloc,
      Stream.value(const FavoriteState([])),
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
    await _errorFixture(bloc, tester, app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should invoke a refresh on rejection', (tester) async {
    await _errorFixture(bloc, tester, app);
    await tester.tap(find.text('ОБНОВИТЬ'));

    verify(() => bloc.add(const FavoriteEvent.refresh())).called(1);
  });
}

Future _errorFixture(FavoriteBloc bloc, WidgetTester tester, Widget app) async {
  whenListen(
    bloc,
    Stream.value(const FavoriteState([])),
    initialState: FavoriteState.error(Rejection('reason')),
  );

  await tester.pumpWidget(app);
}

Future<void> _standartFixture(
  WidgetTester tester,
  FavoriteBloc bloc,
  Widget app,
) async {
  whenListen(
    bloc,
    Stream.value(const FavoriteState([])),
    initialState: FavoriteState([
      Favorite(1, 1, 'Chat 1'),
      Favorite(1, 1, 'Chat 2'),
    ]),
  );

  await tester.pumpWidget(app);
}
