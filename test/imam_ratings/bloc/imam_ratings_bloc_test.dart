import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/imam_ratings/bloc/imam_ratings_bloc.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:askimam/imam_ratings/domain/model/imam_ratings_with_description.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'imam_ratings_bloc_test.mocks.dart';

@GenerateMocks([ImamRatingsRepo])
void main() {
  late ImamRatingsBloc bloc;
  late ImamRatingsRepo repo;

  setUp(() {
    repo = MockImamRatingsRepo();
    bloc = ImamRatingsBloc(repo);
  });

  test('initial state', () {
    expect(bloc.state, const ImamRatingsState.inProgress());
  });

  blocTest(
    'should get ratings',
    build: () {
      when(repo.getRatings()).thenAnswer(
        (_) async => right(ImamRatingsWithDescription('description', [
          ImamRating('Imam 1', 123),
          ImamRating('Imam 2', 12),
        ])),
      );

      return bloc;
    },
    act: (_) => bloc.add(const ImamRatingsEvent.reload()),
    expect: () => [
      const ImamRatingsState.inProgress(),
      ImamRatingsState(
        ImamRatingsWithDescription('description', [
          ImamRating('Imam 1', 123),
          ImamRating('Imam 2', 12),
        ]),
      ),
    ],
  );

  blocTest(
    'should not get ratings',
    build: () {
      when(repo.getRatings())
          .thenAnswer((_) async => left(Rejection('reason')));

      return bloc;
    },
    act: (_) => bloc.add(const ImamRatingsEvent.reload()),
    expect: () => [
      const ImamRatingsState.inProgress(),
      ImamRatingsState.error(Rejection('reason')),
    ],
  );
}
