import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepository {
  Future<Either<Rejection, List<Favorite>>> getMyFavorites();

  Future<Option<Rejection>> delete(Favorite favorite);
}
