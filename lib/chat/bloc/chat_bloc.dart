import 'dart:async';

import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/common/utils.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_bloc.freezed.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;

  ChatBloc(this._repo) : super(_InProgress());

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) => event.when(
        refresh: _refresh,
        updateSubject: _updateSubject,
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
