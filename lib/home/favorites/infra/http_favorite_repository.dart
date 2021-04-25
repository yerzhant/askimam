import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/add_chat_to_favorites.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:askimam/home/favorites/domain/repo/favorite_repository.dart';
import 'package:dartz/dartz.dart';

const _url = 'favorites';

class HttpFavoriteRepository implements FavoriteRepository {
  final ApiClient _apiClient;

  const HttpFavoriteRepository(this._apiClient);

  @override
  Future<Either<Rejection, List<Favorite>>> get() async {
    return _apiClient.getList<Favorite>(_url);
  }

  @override
  Future<Option<Rejection>> add(Chat chat) async {
    return _apiClient.post(_url, AddChatToFavorites(chat.id));
  }

  @override
  Future<Option<Rejection>> delete(int chatId) async {
    return _apiClient.delete('$_url/$chatId');
  }
}
