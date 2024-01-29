part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

final class FavoriteStateSuccess extends FavoriteState {
  final List<Favorite> favorites;

  const FavoriteStateSuccess(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class FavoriteStateInProgress extends FavoriteState {
  final List<Favorite> favorites;

  const FavoriteStateInProgress(this.favorites);

  @override
  List<Object?> get props => [favorites];
}

final class FavoriteStateError extends FavoriteState {
  final Rejection rejection;

  const FavoriteStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
