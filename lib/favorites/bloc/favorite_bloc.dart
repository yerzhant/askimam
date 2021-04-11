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
        refresh: _mapRefreshToState,
        delete: _mapDeleteToState,
      );

  Stream<FavoriteState> _mapRefreshToState() async* {
    yield FavoriteState.inProgress([]);

    final result = await _repo.getMyFavorites();

    yield result.fold(
      (l) => FavoriteState.error(l),
      (r) => FavoriteState(r),
    );
  }

  Stream<FavoriteState> _mapDeleteToState(Favorite favorite) async* {
    yield state.when(
      (myFavorites) => FavoriteState.inProgress(myFavorites),
      inProgress: (myFavorites) => FavoriteState.inProgress(myFavorites),
      error: (rejection) => FavoriteState.error(rejection),
    );

    final result = await _repo.delete(favorite);

    yield result.fold(
      () => state.when(
        (myFavorites) => FavoriteState.error(Rejection('error')),
        inProgress: (myFavorites) => FavoriteState(
          myFavorites.where((element) => element != favorite).toList(),
        ),
        error: (rejection) => throw Error(),
      ),
      (a) => FavoriteState.error(a),
    );
  }
}
