import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/imam_ratings/domain/model/imam_ratings_with_description.dart';
import 'package:dartz/dartz.dart';

abstract class ImamRatingsRepo {
  Future<Either<Rejection, ImamRatingsWithDescription>> getRatings();
}
