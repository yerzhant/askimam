import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:dartz/dartz.dart';

abstract class ImamRatingsRepo {
  Future<Either<Rejection, List<ImamRating>>> getRatings();
}
