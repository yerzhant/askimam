import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/imam_ratings/bloc/imam_ratings_bloc.dart';
import 'package:askimam/imam_ratings/domain/model/imam_rating.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImamRatingsPage extends StatelessWidget {
  final ImamRatingsBloc bloc;

  ImamRatingsPage({Key? key, required this.bloc}) : super(key: key) {
    bloc.add(const ImamRatingsEventReload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рейтинг устазов')),
      body: BlocBuilder<ImamRatingsBloc, ImamRatingsState>(
        bloc: bloc,
        builder: (context, state) {
          return switch (state) {
            ImamRatingsStateSuccess(ratings: final ratings) => Column(
                children: [
                  Expanded(child: _list(ratings.ratings, context)),
                  Padding(
                    padding: const EdgeInsets.all(basePadding),
                    child: Text(
                      ratings.description,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            height: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ImamRatingsStateInProgress() =>
              InProgressWidget(child: Container()),
            ImamRatingsStateError(rejection: final rejection) =>
              RejectionWidget(
                rejection: rejection,
                onRefresh: () => bloc.add(const ImamRatingsEventReload()),
              ),
          };
        },
      ),
    );
  }

  Widget _list(List<ImamRating> items, BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

        return ListTile(
          title: AutoDirection(
            text: item.name,
            child: Text(item.name),
          ),
          trailing: Text(item.rating.toString()),
          leadingAndTrailingTextStyle: Theme.of(context).textTheme.bodyLarge,
        );
      },
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
