import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/imam_ratings/domain/repo/imam_ratings_repo.dart';
import 'package:dartz/dartz.dart';

class HttpImamRatingsRepo implements ImamRatingsRepo {
  final ApiClient _apiClient;

  const HttpImamRatingsRepo(this._apiClient);

  @override
  Future<Either<Rejection, List<ImamRating>>> getRatings() =>
      _apiClient.getList('imam-ratings');
}
