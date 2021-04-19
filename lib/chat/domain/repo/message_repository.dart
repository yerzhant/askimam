import 'package:askimam/common/domain/model/rejection.dart';
import 'package:dartz/dartz.dart';

abstract class MessageRepository {
  Future<Option<Rejection>> addText(int chatId, String text);
  Future<Option<Rejection>> delete(int chatId, int messageId);
  Future<Option<Rejection>> updateText(int chatId, int messageId, String text);
}
