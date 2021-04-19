import 'dart:async';

import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/favorites/domain/model/favorite.dart';
import 'package:askimam/favorites/domain/repo/favorite_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';
part 'favorite_bloc.freezed.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository _repo;

  FavoriteBloc(this._repo) : super(_InProgress([]));

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
      orElse: () => add(FavoriteEvent.refresh()),
    );
  }

  Stream<FavoriteState> _refresh() async* {
    yield FavoriteState.inProgress([]);

    final result = await _repo.get();

    yield result.fold(
      (l) => FavoriteState.error(l),
      (r) => FavoriteState(r),
    );
  }

  Stream<FavoriteState> _add(Favorite favorite) async* {
    Stream<FavoriteState> add(List<Favorite> favorites) async* {
      yield FavoriteState.inProgress(favorites);

      final result = await _repo.add(favorite);

      yield result.fold(
        () => FavoriteState(favorites..insert(0, favorite)),
        (a) => FavoriteState.error(a),
      );
    }

    yield* state.when(
      (favorites) => add(favorites),
      inProgress: (favorites) => add(favorites),
      error: (rejection) async* {
        yield FavoriteState.error(rejection);
      },
    );
  }

  Stream<FavoriteState> _delete(Favorite favorite) async* {
    Stream<FavoriteState> delete(List<Favorite> favorites) async* {
      yield FavoriteState.inProgress(favorites);

      final result = await _repo.delete(favorite);

      yield result.fold(
        () => FavoriteState(
          favorites.where((element) => element != favorite).toList(),
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
