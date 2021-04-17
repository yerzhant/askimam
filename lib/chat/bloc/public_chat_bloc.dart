import 'dart:async';

import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_chat_event.dart';
part 'public_chat_state.dart';
part 'public_chat_bloc.freezed.dart';

class PublicChatBloc extends Bloc<PublicChatEvent, PublicChatState> {
  final ChatRepository _repo;
  final int _pageSize;

  PublicChatBloc(this._repo, this._pageSize) : super(_InProgress([]));

  @override
  Stream<PublicChatState> mapEventToState(PublicChatEvent event) => event.when(
        reload: _mapReloadToState,
        loadNextPage: _mapLoadNextPageToState,
      );

  Stream<PublicChatState> _mapReloadToState() async* {
    yield PublicChatState.inProgress([]);

    final result = await _repo.getPublic(0, _pageSize);

    yield result.fold(
      (l) => PublicChatState.error(l),
      (r) => PublicChatState(r),
    );
  }

  Stream<PublicChatState> _mapLoadNextPageToState() async* {
    Stream<PublicChatState> load(List<Chat> chats) async* {
      yield PublicChatState.inProgress(chats);

      final result = await _repo.getPublic(chats.length, _pageSize);

      yield result.fold(
        (l) => PublicChatState.error(l),
        (r) => PublicChatState(chats..addAll(r)),
      );
    }

    yield* state.when(
      (chats) => load(chats),
      inProgress: (chats) async* {
        yield PublicChatState.inProgress(chats);
      },
      error: (rejection) async* {
        yield PublicChatState.error(rejection);
      },
    );
  }
}
