import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/ui/widget/circular_progress.dart';
import 'package:askimam/imam_ratings/bloc/imam_ratings_bloc.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:askimam/imam_ratings/domain/model/imam_ratings_with_description.dart';
import 'package:askimam/imam_ratings/ui/imam_ratings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'imam_ratings_page_test.mocks.dart';

@GenerateMocks([ImamRatingsBloc])
void main() {
  late Widget app;
  late ImamRatingsBloc bloc;

  setUp(() {
    provideDummy<ImamRatingsState>(const ImamRatingsStateInProgress());

    bloc = MockImamRatingsBloc();
    when(bloc.state).thenReturn(const ImamRatingsStateInProgress());
    when(bloc.stream).thenAnswer((_) => const Stream.empty());

    app = MaterialApp(
      home: ImamRatingsPage(bloc: bloc),
    );
  });

  testWidgets('should be in progress', (tester) async {
    await tester.pumpWidget(app);

    expect(find.byType(CircularProgress), findsOneWidget);

    verify(bloc.add(const ImamRatingsEventReload())).called(1);
  });

  testWidgets('should show ratings', (tester) async {
    when(bloc.state).thenReturn(
      const ImamRatingsStateSuccess(
        ImamRatingsWithDescription('description', [
          ImamRating('Imam 1', 123),
          ImamRating('Imam 2', 12),
        ]),
      ),
    );

    await tester.pumpWidget(app);

    expect(find.text('Рейтинг устазов'), findsOneWidget);
    expect(find.text('Imam 1'), findsOneWidget);
    expect(find.text('Imam 2'), findsOneWidget);
    expect(find.text('123'), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('description'), findsOneWidget);
  });

  testWidgets('should show error', (tester) async {
    when(bloc.state).thenReturn(ImamRatingsStateError(Rejection('reason')));

    await tester.pumpWidget(app);

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should reload the page', (tester) async {
    when(bloc.state).thenReturn(ImamRatingsStateError(Rejection('reason')));

    await tester.pumpWidget(app);
    reset(bloc);
    await tester.tap(find.text('ПОВТОРИТЬ'));

    verify(bloc.add(const ImamRatingsEventReload())).called(1);
  });
}
