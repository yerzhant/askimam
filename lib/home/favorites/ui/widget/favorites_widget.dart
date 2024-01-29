import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:askimam/home/favorites/domain/model/favorite.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class FavoritesWidget extends StatelessWidget {
  const FavoritesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return switch (state) {
          FavoriteStateSuccess(favorites: final items) => _list(items, context),
          FavoriteStateInProgress(favorites: final items) =>
            InProgressWidget(child: _list(items, context)),
          FavoriteStateError(rejection: final rejection) => RejectionWidget(
              rejection: rejection,
              onRefresh: () => context
                  .read<FavoriteBloc>()
                  .add(const FavoriteEventRefresh()),
            ),
        };
      },
    );
  }

  Widget _list(List<Favorite> items, BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async =>
          context.read<FavoriteBloc>().add(const FavoriteEventRefresh()),
      child: ListView.separated(
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) => context
                .read<FavoriteBloc>()
                .add(FavoriteEventDelete(item.chatId)),
            background: Container(color: warningColor),
            child: ListTile(
              title: AutoDirection(
                text: item.subject,
                child: Text(
                  item.subject,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              minVerticalPadding: listTileMinVertPadding,
              onTap: () => Modular.to.pushNamed('/chat/${item.chatId}'),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        key: const PageStorageKey('favorites'),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
