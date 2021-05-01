import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return state.when(
          (items) => _list(items, context),
          inProgress: (items) => InProgressWidget(child: _list(items, context)),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () =>
                context.read<FavoriteBloc>().add(const FavoriteEvent.refresh()),
          ),
        );
      },
    );
  }

  Widget _list(List<Favorite> items, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<FavoriteBloc>().add(const FavoriteEvent.refresh()),
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) => context
                .read<FavoriteBloc>()
                .add(FavoriteEvent.delete(item.chatId)),
            background: Container(color: Colors.red),
            child: ListTile(
              title: AutoDirection(
                text: item.subject,
                child: Text(item.subject),
              ),
              onTap: () => Modular.to.pushNamed('/chat/${item.chatId}'),
            ),
          );
        },
        key: const PageStorageKey('favorites'),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(vertical: basePadding),
      ),
    );
  }
}
