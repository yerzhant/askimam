import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/chat/domain/repo/message_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_bloc.freezed.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;
  final MessageRepository _messageRepo;

  ChatBloc(this._repo, this._messageRepo) : super(_InProgress());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) => event.when(
        refresh: _refresh,
        addText: _addText,
        deleteMessage: _deleteMessage,
        updateSubject: _updateSubject,
        updateTextMessage: _updateTextMessage,
        returnToUnaswered: _returnToUnaswered,
      );

  Stream<ChatState> _refresh(int id) async* {
    yield ChatState.inProgress();

    final result = await _repo.get(id);

    yield* result.fold(
      (l) async* {
        yield ChatState.error(l);
      },
      (r) async* {
        final setViewedFlagResult = await _repo.setViewedFlag(id);

        yield setViewedFlagResult.fold(
          () => ChatState(r),
          (a) => ChatState.error(a),
        );
      },
    );
  }

  Stream<ChatState> _addText(String text) async* {
    yield* state.maybeWhen(
      (chat, rejection, isInProgress, isSuccess) async* {
        yield ChatState(chat, isInProgress: true);

        final result = await _messageRepo.addText(chat.id, text);

        yield* result.fold(
          () async* {
            final updateResult = await _repo.get(chat.id);

            yield updateResult.fold(
              (l) => ChatState(chat, rejection: l),
              (r) => ChatState(r),
            );
          },
          (a) async* {
            yield ChatState(chat, rejection: a);
          },
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<ChatState> _updateTextMessage(int id, String text) async* {
    yield* state.maybeWhen(
      (chat, rejection, isInProgress, isSuccess) async* {
        yield ChatState(chat, isInProgress: true);

        final result = await _messageRepo.updateText(chat.id, id, text);

        yield result.fold(
          () => ChatState(
            chat.copyWith(
              messages: chat.messages
                  ?.map((m) => m.id == id ? m.copyWith(text: text) : m)
                  .toList(),
            ),
          ),
          (a) => ChatState(chat, rejection: a),
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<ChatState> _deleteMessage(int id) async* {
    yield* state.maybeWhen(
      (chat, rejection, isInProgress, isSuccess) async* {
        yield ChatState(chat, isInProgress: true);

        final result = await _messageRepo.delete(chat.id, id);

        yield result.fold(
          () => ChatState(
            chat.copyWith(
              messages: chat.messages?.whereNot((m) => m.id == id).toList(),
            ),
          ),
          (a) => ChatState(chat, rejection: a),
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<ChatState> _updateSubject(String subject) async* {
    yield* state.maybeWhen(
      (chat, rejection, isInProgress, isSuccess) async* {
        yield ChatState(chat, isInProgress: true);

        final result = await _repo.updateSubject(chat.id, subject);

        yield result.fold(
          () => ChatState(chat, isSuccess: true),
          (a) => ChatState(chat, rejection: a),
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<ChatState> _returnToUnaswered() async* {
    yield* state.maybeWhen(
      (chat, rejection, isInProgress, isSuccess) async* {
        yield ChatState(chat, isInProgress: true);

        final result = await _repo.returnToUnanswered(chat.id);

        yield result.fold(
          () => ChatState(chat, isSuccess: true),
          (a) => ChatState(chat, rejection: a),
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }
}
