import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chat/domain/repo/chat_repository.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'public_chats_event.dart';
part 'public_chats_state.dart';
part 'public_chats_bloc.freezed.dart';

class PublicChatsBloc extends Bloc<PublicChatsEvent, PublicChatsState> {
  final ChatRepository _repo;
  final FavoriteBloc _favoriteBloc;
  final int _pageSize;
  late StreamSubscription _subscription;

  PublicChatsBloc(
    this._repo,
    this._favoriteBloc,
    this._pageSize,
  ) : super(_InProgress([])) {
    _subscription = _favoriteBloc.stream.listen((state) {
      state.maybeWhen(
        (favorites) => add(PublicChatsEvent.updateFavorites(favorites)),
        orElse: () {},
      );
    });
  }

  @override
  Stream<PublicChatsState> mapEventToState(PublicChatsEvent event) =>
      event.when(
        show: _show,
        reload: _reload,
        loadNextPage: _loadNextPage,
        updateFavorites: _updateFavorites,
      );

  Stream<PublicChatsState> _show() async* {
    state.maybeWhen(
      (chats) async* {
        yield PublicChatsState(chats);
      },
      orElse: () => add(PublicChatsEvent.reload()),
    );
  }

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

  Stream<PublicChatsState> _updateFavorites(List<Favorite> favorites) async* {
    yield state.maybeWhen(
      (chats) => PublicChatsState(chats
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
