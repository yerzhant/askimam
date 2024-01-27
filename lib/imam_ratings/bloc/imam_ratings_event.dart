part of 'imam_ratings_bloc.dart';

sealed class ImamRatingsEvent extends Equatable {
  const ImamRatingsEvent();

  @override
  List<Object?> get props => [];
}

final class ImamRatingsEventReload extends ImamRatingsEvent {
  const ImamRatingsEventReload();
}
