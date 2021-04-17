import 'dart:async';

import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_chats_event.dart';
part 'public_chats_state.dart';
part 'public_chats_bloc.freezed.dart';

class PublicChatsBloc extends Bloc<PublicChatsEvent, PublicChatsState> {
  final ChatRepository _repo;
  final int _pageSize;

  PublicChatsBloc(this._repo, this._pageSize) : super(_InProgress([]));

  @override
  Stream<PublicChatsState> mapEventToState(PublicChatsEvent event) =>
      event.when(
        reload: _reload,
        loadNextPage: _loadNextPage,
      );

  Stream<PublicChatsState> _reload() async* {
    yield PublicChatsState.inProgress([]);

    final result = await _repo.getPublic(0, _pageSize);

    yield result.fold(
      (l) => PublicChatsState.error(l),
      (r) => PublicChatsState(r),
    );
  }

  Stream<PublicChatsState> _loadNextPage() async* {
    Stream<PublicChatsState> load(List<Chat> chats) async* {
      yield PublicChatsState.inProgress(chats);

      final result = await _repo.getPublic(chats.length, _pageSize);

      yield result.fold(
        (l) => PublicChatsState.error(l),
        (r) => PublicChatsState(chats..addAll(r)),
      );
    }

    yield* state.when(
      (chats) => load(chats),
      inProgress: (chats) async* {
        yield PublicChatsState.inProgress(chats);
      },
      error: (rejection) async* {
        yield PublicChatsState.error(rejection);
      },
    );
  }
}
