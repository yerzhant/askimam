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
    bloc.add(const ImamRatingsEvent.reload());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Рейтинг устазов')),
      body: BlocBuilder<ImamRatingsBloc, ImamRatingsState>(
        bloc: bloc,
        builder: (context, state) {
          return state.when(
            (ratings) => Column(
              children: [
                Expanded(child: _list(ratings.ratings)),
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
            inProgress: () => InProgressWidget(child: Container()),
            error: (rejection) => RejectionWidget(
              rejection: rejection,
              onRefresh: () => bloc.add(const ImamRatingsEvent.reload()),
            ),
          );
        },
      ),
    );
  }

  Widget _list(List<ImamRating> items) {
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
        );
      },
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.symmetric(vertical: basePadding),
    );
  }
}
