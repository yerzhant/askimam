import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/domain/add_chat_to_favorites.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:askimam/favorites/domain/favorite_repository.dart';
import 'package:dartz/dartz.dart';

const _url = 'favorites';

class HttpFavoriteRepository implements FavoriteRepository {
  final ApiClient _apiClient;

  const HttpFavoriteRepository(this._apiClient);

  @override
  Future<Either<Rejection, List<Favorite>>> get() async {
    return await _apiClient.getList<Favorite>(_url);
  }

  @override
  Future<Option<Rejection>> add(Favorite favorite) async {
    return await _apiClient.post(_url, AddChatToFavorites(favorite.chatId));
  }

  @override
  Future<Option<Rejection>> delete(Favorite favorite) async {
    return await _apiClient.delete('$_url/${favorite.id}');
  }
}
