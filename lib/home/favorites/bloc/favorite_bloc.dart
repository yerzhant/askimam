import 'dart:async';

import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:askimam/home/favorites/domain/repo/favorite_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';
part 'favorite_bloc.freezed.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository _repo;

  FavoriteBloc(this._repo) : super(const _InProgress([]));

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) => event.when(
        show: _show,
        refresh: _refresh,
        add: _add,
        delete: _delete,
      );

  Stream<FavoriteState> _show() async* {
    state.maybeWhen(
      (favorites) => FavoriteState(favorites),
      orElse: () => add(const FavoriteEvent.refresh()),
    );
  }

  Stream<FavoriteState> _refresh() async* {
    yield const FavoriteState.inProgress([]);

    final result = await _repo.get();

    yield result.fold(
      (l) => FavoriteState.error(l),
      (r) => FavoriteState(r),
    );
  }

  Stream<FavoriteState> _add(Chat chat) async* {
    Stream<FavoriteState> addIt(List<Favorite> favorites) async* {
      yield FavoriteState.inProgress(favorites);

      final result = await _repo.add(chat);

      yield* result.fold(
        () async* {
          add(const FavoriteEvent.refresh());
        },
        (a) async* {
          yield FavoriteState.error(a);
        },
      );
    }

    yield* state.when(
      (favorites) => addIt(favorites),
      inProgress: (favorites) => addIt(favorites),
      error: (rejection) async* {
        yield FavoriteState.error(rejection);
      },
    );
  }

  Stream<FavoriteState> _delete(int chatId) async* {
    Stream<FavoriteState> delete(List<Favorite> favorites) async* {
      yield FavoriteState.inProgress(favorites);

      final result = await _repo.delete(chatId);

      yield result.fold(
        () => FavoriteState(
          favorites.whereNot((f) => f.chatId == chatId).toList(),
        ),
        (a) => FavoriteState.error(a),
      );
    }

    yield* state.when(
      (favorites) => delete(favorites),
      inProgress: (favorites) => delete(favorites),
      error: (rejection) async* {
        yield FavoriteState.error(rejection);
      },
    );
  }
}
