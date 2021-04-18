import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Rejection, List<Chat>>> getPublic(int offset, int pageSize);
  Future<Either<Rejection, List<Chat>>> getMy(int offset, int pageSize);
  Future<Either<Rejection, List<Chat>>> getUnanswered(int offset, int pageSize);
  Future<Option<Rejection>> delete(Chat chat);
}
