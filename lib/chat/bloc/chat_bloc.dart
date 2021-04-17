import 'dart:async';

import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _repo;
  final int _pageSize;

  ChatBloc(this._repo, this._pageSize) : super(_InProgress([]));

  @override
  Stream<ChatState> mapEventToState(ChatEvent event) => event.when(
        reloadPublic: _mapReloadPublicToState,
        loadNextPublicPage: _mapLoadNextPublicPageToState,
      );

  Stream<ChatState> _mapReloadPublicToState() async* {
    yield ChatState.inProgress([]);

    final result = await _repo.getPublic(0, _pageSize);

    yield result.fold(
      (l) => ChatState.error(l),
      (r) => ChatState(r),
    );
  }

  Stream<ChatState> _mapLoadNextPublicPageToState() async* {
    Stream<ChatState> load(List<Chat> public) async* {
      yield ChatState.inProgress(public);

      final result = await _repo.getPublic(public.length, _pageSize);

      yield result.fold(
        (l) => ChatState.error(l),
        (r) => ChatState(public..addAll(r)),
      );
    }

    yield* state.when(
      (public) => load(public),
      inProgress: (public) async* {
        yield ChatState.inProgress(public);
      },
      error: (rejection) async* {
        yield ChatState.error(rejection);
      },
    );
  }
}
