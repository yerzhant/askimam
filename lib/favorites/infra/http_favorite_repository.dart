import 'package:askimam/common/domain/apiClient.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:askimam/favorites/domain/favorite_repository.dart';
import 'package:dartz/dartz.dart';

class HttpFavoriteRepository implements FavoriteRepository {
  final ApiClient _apiClient;

  const HttpFavoriteRepository(this._apiClient);

  @override
  Future<Either<Rejection, List<Favorite>>> getMyFavorites() async {
    return await _apiClient.getList<Favorite>('favorites');
  }

  @override
  Future<Option<Rejection>> delete(Favorite favorite) async {
    return await _apiClient.delete('favorites/${favorite.id}');
  }
}
