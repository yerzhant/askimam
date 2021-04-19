import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepository {
  Future<Either<Rejection, List<Favorite>>> get();
  Future<Option<Rejection>> add(Favorite favorite);
  Future<Option<Rejection>> delete(Favorite favorite);
}
