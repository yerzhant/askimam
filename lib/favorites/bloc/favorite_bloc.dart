import 'dart:async';

import 'package:askimam/common/domain/rejection.dart';
import 'package:askimam/favorites/domain/favorite.dart';
import 'package:askimam/favorites/domain/favorite_repository.dart';
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
        refresh: _mapRefreshToState,
        delete: _mapDeleteToState,
      );

  Stream<FavoriteState> _show() async* {
    state.maybeWhen(
      (myFavorites) => FavoriteState(myFavorites),
      orElse: () => add(FavoriteEvent.refresh()),
    );
  }

  Stream<FavoriteState> _mapRefreshToState() async* {
    yield FavoriteState.inProgress([]);

    final result = await _repo.getMyFavorites();

    yield result.fold(
      (l) => FavoriteState.error(l),
      (r) => FavoriteState(r),
    );
  }

  Stream<FavoriteState> _mapDeleteToState(Favorite favorite) async* {
    Stream<FavoriteState> delete(List<Favorite> myFavorites) async* {
      yield FavoriteState.inProgress(myFavorites);

      final result = await _repo.delete(favorite);

      yield result.fold(
        () => FavoriteState(
          myFavorites.where((element) => element != favorite).toList(),
        ),
        (a) => FavoriteState.error(a),
      );
    }

    yield* state.when(
      (myFavorites) => delete(myFavorites),
      inProgress: (myFavorites) => delete(myFavorites),
      error: (rejection) async* {
        yield FavoriteState.error(rejection);
      },
    );
  }
}
