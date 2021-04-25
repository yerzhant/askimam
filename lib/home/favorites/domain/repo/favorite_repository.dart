import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:dartz/dartz.dart';

abstract class FavoriteRepository {
  Future<Either<Rejection, List<Favorite>>> get();
  Future<Option<Rejection>> add(Chat chat);
  Future<Option<Rejection>> delete(int chatId);
}
