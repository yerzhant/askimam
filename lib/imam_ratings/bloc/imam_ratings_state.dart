part of 'imam_ratings_bloc.dart';

@freezed
class ImamRatingsState with _$ImamRatingsState {
  const factory ImamRatingsState(List<ImamRating> ratings) = _State;
  const factory ImamRatingsState.inProgress() = _InProgress;
  const factory ImamRatingsState.error(Rejection rejection) = _Error;
}
