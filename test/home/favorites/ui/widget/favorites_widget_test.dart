import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:askimam/home/favorites/ui/widget/favorites_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'favorites_widget_test.mocks.dart';

@GenerateMocks([FavoriteBloc, IModularNavigator])
void main() {
  late FavoriteBloc bloc;
  late IModularNavigator navigator;
  late Widget app;

  setUp(() {
    bloc = MockFavoriteBloc();
    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;

    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    app = MaterialApp(
      home: BlocProvider.value(
        value: bloc,
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

  testWidgets('should route to a chat', (tester) async {
    await _standartFixture(tester, bloc, app);
    await tester.tap(find.text('Chat 1'));

    verify(navigator.navigate('/chat/11')).called(1);
  });

  testWidgets('should invoke a refresh on pulling down', (tester) async {
    await _standartFixture(tester, bloc, app);
    await tester.fling(find.text('Chat 1'), const Offset(0.0, 300.0), 1000.0);
    await tester.pumpAndSettle();

    verify(bloc.add(const FavoriteEvent.refresh())).called(1);
  });

  testWidgets('should delete an item', (tester) async {
    await _standartFixture(tester, bloc, app);
    await tester.drag(find.text('Chat 1'), const Offset(-500, 0));
    await tester.pumpAndSettle();

    verify(bloc.add(const FavoriteEvent.delete(11))).called(1);
  });

  testWidgets('should show a list and progress', (tester) async {
    when(bloc.state).thenReturn(
      FavoriteState.inProgress([
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
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const FavoriteEvent.refresh())).called(1);
  });
}

Future _errorFixture(FavoriteBloc bloc, WidgetTester tester, Widget app) async {
  when(bloc.state).thenReturn(FavoriteState.error(Rejection('reason')));

  await tester.pumpWidget(app);
}

Future<void> _standartFixture(
  WidgetTester tester,
  FavoriteBloc bloc,
  Widget app,
) async {
  when(bloc.state).thenReturn(
    FavoriteState([
      Favorite(1, 11, 'Chat 1'),
      Favorite(1, 12, 'Chat 2'),
    ]),
  );

  await tester.pumpWidget(app);
}
