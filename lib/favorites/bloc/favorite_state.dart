part of 'favorite_bloc.dart';

@freezed
class FavoriteState with _$FavoriteState {
  const factory FavoriteState(List<Favorite> myFavorites) = _State;

  const factory FavoriteState.inProgress(List<Favorite> favorites) =
      _InProgress;

  const factory FavoriteState.error(Rejection rejection) = _Error;
}
