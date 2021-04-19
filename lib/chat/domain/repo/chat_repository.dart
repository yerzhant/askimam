import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<Rejection, Chat>> get(int id);

  Future<Either<Rejection, List<Chat>>> getMy(int offset, int pageSize);
  Future<Either<Rejection, List<Chat>>> getPublic(int offset, int pageSize);
  Future<Either<Rejection, List<Chat>>> getUnanswered(int offset, int pageSize);

  Future<Option<Rejection>> add(ChatType type, String? subject, String text);
  Future<Option<Rejection>> updateSubject(int id, String subject);
  Future<Option<Rejection>> delete(Chat chat);

  Future<Option<Rejection>> setViewedFlag(int id);
  Future<Option<Rejection>> returnToUnanswered(int id);
}
