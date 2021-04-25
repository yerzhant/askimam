import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unanswered_chats_bloc.freezed.dart';
part 'unanswered_chats_event.dart';
part 'unanswered_chats_state.dart';

class UnansweredChatsBloc
    extends Bloc<UnansweredChatsEvent, UnansweredChatsState> {
  final ChatRepository _repo;
  final int _pageSize;

  UnansweredChatsBloc(this._repo, this._pageSize)
      : super(const _InProgress([]));

  @override
  Stream<UnansweredChatsState> mapEventToState(UnansweredChatsEvent event) =>
      event.when(
        show: _show,
        delete: _delete,
        reload: _reload,
        loadNextPage: _loadNextPage,
        updateFavorites: _updateFavorites,
      );

  Stream<UnansweredChatsState> _show() async* {
    state.maybeWhen(
      (chats) async* {
        yield UnansweredChatsState(chats);
      },
      orElse: () => add(const UnansweredChatsEvent.reload()),
    );
  }

  Stream<UnansweredChatsState> _reload() async* {
    yield const UnansweredChatsState.inProgress([]);

    final result = await _repo.getUnanswered(0, _pageSize);

    yield result.fold(
      (l) => UnansweredChatsState.error(l),
      (r) => UnansweredChatsState(r),
    );
  }

  Stream<UnansweredChatsState> _loadNextPage() async* {
    Stream<UnansweredChatsState> load(List<Chat> chats) async* {
      yield UnansweredChatsState.inProgress(chats);

      final result = await _repo.getUnanswered(chats.length, _pageSize);

      yield result.fold(
        (l) => UnansweredChatsState.error(l),
        (r) => UnansweredChatsState(chats..addAll(r)),
      );
    }

    yield* state.when(
      (chats) => load(chats),
      inProgress: (chats) async* {
        yield UnansweredChatsState.inProgress(chats);
      },
      error: (rejection) async* {
        yield UnansweredChatsState.error(rejection);
      },
    );
  }

  Stream<UnansweredChatsState> _delete(Chat chat) async* {
    yield* state.maybeWhen(
      (chats) async* {
        yield UnansweredChatsState.inProgress(chats);

        final result = await _repo.delete(chat);

        yield result.fold(
          () => UnansweredChatsState(
              chats.where((c) => c.id != chat.id).toList()),
          (a) => UnansweredChatsState.error(a),
        );
      },
      orElse: () async* {
        yield state;
      },
    );
  }

  Stream<UnansweredChatsState> _updateFavorites(
      List<Favorite> favorites) async* {
    yield state.maybeWhen(
      (chats) => UnansweredChatsState(chats
          .map(
            (chat) => chat.copyWith(
              isFavorite: favorites.any((f) => f.chatId == chat.id),
            ),
          )
          .toList()),
      orElse: () => state,
    );
  }
}
