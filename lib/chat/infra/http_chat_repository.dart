import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/chat/infra/dto/create_chat.dart';
import 'package:askimam/chat/infra/dto/update_chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:dartz/dartz.dart';

const _url = 'chats';

class HttpChatRepository implements ChatRepository {
  final ApiClient _api;
  final NotificationService _notificationService;

  HttpChatRepository(this._api, this._notificationService);

  @override
  Future<Option<Rejection>> add(
      ChatType type, String? subject, String text) async {
    final tokenResult = await _notificationService.getFcmToken();

    return tokenResult.fold(
      (l) => some(l),
      (r) async {
        final result = await _api.post(
          _url,
          CreateChat(type, subject, text, r),
        );

        return result.fold(
          () => none(),
          (a) => some(a),
        );
      },
    );
  }

  @override
  Future<Option<Rejection>> delete(Chat chat) async {
    final result = await _api.delete('$_url/${chat.id}');

    return result.fold(
      () => none(),
      (a) => some(a),
    );
  }

  @override
  Future<Either<Rejection, Chat>> get(int id) async {
    final result = await _api.get<Chat>('$_url/messages/$id');

    return result.fold(
      (l) => left(l),
      (r) => right(r),
    );
  }

  @override
  Future<Either<Rejection, List<Chat>>> getMy(int offset, int pageSize) async =>
      await _getChats('my', offset, pageSize);

  @override
  Future<Either<Rejection, List<Chat>>> getPublic(
          int offset, int pageSize) async =>
      await _getChats('public', offset, pageSize);

  @override
  Future<Either<Rejection, List<Chat>>> getUnanswered(
          int offset, int pageSize) async =>
      await _getChats('unanswered', offset, pageSize);

  Future<FutureOr<Either<Rejection, List<Chat>>>> _getChats(
    String type,
    int offset,
    int pageSize,
  ) async {
    final result = await _api.getList<Chat>('$_url/$type/$offset/$pageSize');

    return result.fold(
      (l) => left(l),
      (r) => right(r),
    );
  }

  @override
  Future<Either<Rejection, List<Chat>>> find(String phrase) =>
      _api.getList<Chat>('$_url/find/$phrase');

  @override
  Future<Option<Rejection>> returnToUnanswered(int id) async {
    final result = await _api.patch('$_url/$id/return-to-unanswered');

    return result.fold(
      () => none(),
      (a) => some(a),
    );
  }

  @override
  Future<Option<Rejection>> setViewedFlag(int id) async {
    final result = await _api.patch('$_url/$id/viewed-by');

    return result.fold(
      () => none(),
      (a) => some(a),
    );
  }

  @override
  Future<Option<Rejection>> updateSubject(int id, String subject) async {
    final result = await _api.patchWithBody('$_url/$id', UpdateChat(subject));

    return result.fold(
      () => none(),
      (a) => some(a),
    );
  }
}
