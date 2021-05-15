import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:askimam/imam_ratings/domain/model/imam_ratings_with_description.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:askimam/imam_ratings/infra/http_imam_ratings_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../auth/bloc/auth_bloc_test.mocks.dart';

void main() {
  late ApiClient apiClient;
  late ImamRatingsRepo repo;

  setUp(() {
    apiClient = MockApiClient();
    repo = HttpImamRatingsRepo(apiClient);
  });

  test('should get ratings', () async {
    final list = [
      ImamRating('Imam 1', 123),
      ImamRating('Imam 2', 12),
    ];
    when(
      apiClient.get<ImamRatingsWithDescription>('imam-ratings/with-desc'),
    ).thenAnswer(
      (_) async => right(ImamRatingsWithDescription('description', list)),
    );

    final result = await repo.getRatings();

    expect(result, right(ImamRatingsWithDescription('description', list)));
  });

  test('should not get ratings', () async {
    when(apiClient.get<ImamRatingsWithDescription>('imam-ratings/with-desc'))
        .thenAnswer((_) async => left(Rejection('reason')));

    final result = await repo.getRatings();

    expect(result, left(Rejection('reason')));
  });
}
