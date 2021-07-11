import 'dart:io';

import 'package:askimam/chat/domain/repo/message_repository.dart';
import 'package:askimam/chat/infra/dto/add_audio_message.dart';
import 'package:askimam/chat/infra/dto/add_text_message.dart';
import 'package:askimam/chat/infra/dto/update_text_message.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/domain/service/notification_service.dart';
import 'package:dartz/dartz.dart';

const _url = 'messages';

class HttpMessageRepository implements MessageRepository {
  final ApiClient _api;
  final NotificationService _notificationService;

  const HttpMessageRepository(this._api, this._notificationService);

  @override
  Future<Option<Rejection>> addText(int chatId, String text) async {
    final tokenResult = await _notificationService.getFcmToken();

    return tokenResult.fold(
      (l) => some(l),
      (r) => _api.post(_url, AddTextMessage(chatId, text, r)),
    );
  }

  @override
  Future<Option<Rejection>> addAudio(
      int chatId, File audio, String duration) async {
    final tokenResult = await _notificationService.getFcmToken();

    return tokenResult.fold(
      (l) => some(l),
      (fcmToken) async {
        final uploadResult = await _api.uploadFile('$_url/upload-audio', audio);

        return uploadResult.fold(
          () => _api.post(
            '$_url/audio',
            AddAudioMessage(
              chatId,
              audio.path.split('/').last,
              duration,
              fcmToken,
            ),
          ),
          (a) => some(a),
        );
      },
    );
  }

  @override
  Future<Option<Rejection>> delete(int chatId, int messageId) =>
      _api.delete('$_url/$chatId/$messageId');

  @override
  Future<Option<Rejection>> updateText(
      int chatId, int messageId, String text) async {
    final tokenResult = await _notificationService.getFcmToken();

    return tokenResult.fold(
      (l) => some(l),
      (r) => _api.patchWithBody(
          '$_url/$chatId/$messageId', UpdateTextMessage(text, r)),
    );
  }
}
