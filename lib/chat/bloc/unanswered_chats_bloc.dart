import 'dart:async';

import 'package:askimam/chat/domain/chat.dart';
import 'package:askimam/chat/domain/chat_repository.dart';
import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'unanswered_chats_event.dart';
part 'unanswered_chats_state.dart';
part 'unanswered_chats_bloc.freezed.dart';

class UnansweredChatsBloc
    extends Bloc<UnansweredChatsEvent, UnansweredChatsState> {
  final ChatRepository _repo;
  final FavoriteBloc _favoriteBloc;
  final int _pageSize;
  late StreamSubscription _subscription;

  UnansweredChatsBloc(
    this._repo,
    this._favoriteBloc,
    this._pageSize,
  ) : super(_InProgress([])) {
    _subscription = _favoriteBloc.stream.listen((state) {
      state.maybeWhen(
        (favorites) => add(UnansweredChatsEvent.updateFavorites(favorites)),
        orElse: () {},
      );
    });
  }

  @override
  Stream<UnansweredChatsState> mapEventToState(UnansweredChatsEvent event) =>
      event.when(
        show: _show,
        reload: _reload,
        loadNextPage: _loadNextPage,
        updateFavorites: _updateFavorites,
      );

  Stream<UnansweredChatsState> _show() async* {
    state.maybeWhen(
      (chats) async* {
        yield UnansweredChatsState(chats);
      },
      orElse: () => add(UnansweredChatsEvent.reload()),
    );
  }

  Stream<UnansweredChatsState> _reload() async* {
    yield UnansweredChatsState.inProgress([]);

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

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
