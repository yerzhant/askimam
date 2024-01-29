part of 'imam_ratings_bloc.dart';

sealed class ImamRatingsState extends Equatable {
  const ImamRatingsState();

  @override
  List<Object?> get props => [];
}

final class ImamRatingsStateSuccess extends ImamRatingsState {
  final ImamRatingsWithDescription ratings;

  const ImamRatingsStateSuccess(this.ratings);

  @override
  List<Object?> get props => [ratings];
}

final class ImamRatingsStateInProgress extends ImamRatingsState {
  const ImamRatingsStateInProgress();
}

final class ImamRatingsStateError extends ImamRatingsState {
  final Rejection rejection;

  const ImamRatingsStateError(this.rejection);

  @override
  List<Object?> get props => [rejection];
}
