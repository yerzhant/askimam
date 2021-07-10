import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PublicChatsWidget extends StatefulWidget {
  const PublicChatsWidget();

  @override
  _PublicChatsWidgetState createState() => _PublicChatsWidgetState();
}

class _PublicChatsWidgetState extends State<PublicChatsWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadNextPage);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextPage);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadNextPage() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      context
          .read<PublicChatsBloc>()
          .add(const PublicChatsEvent.loadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublicChatsBloc, PublicChatsState>(
      builder: (context, state) {
        return state.when(
          (items) => _list(items, context),
          inProgress: (items) => InProgressWidget(child: _list(items, context)),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () => context
                .read<PublicChatsBloc>()
                .add(const PublicChatsEvent.reload()),
          ),
        );
      },
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<PublicChatsBloc>().add(const PublicChatsEvent.reload()),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return ListTile(
            title: AutoDirection(
              text: item.subject,
              child: Text(
                item.subject,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            minVerticalPadding: listTileMinVertPadding,
            subtitle: Padding(
              padding: const EdgeInsets.only(top: dateTopPadding),
              child: Text(
                item.updatedAt.format(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
            trailing: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return state.maybeWhen(
                  authenticated: (_) => IconButton(
                    icon: Icon(
                      item.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                      color: primaryColor,
                      size: iconSize,
                    ),
                    onPressed: () => context.read<FavoriteBloc>().add(
                          item.isFavorite
                              ? FavoriteEvent.delete(item.id)
                              : FavoriteEvent.add(item),
                        ),
                  ),
                  orElse: () => Container(width: 0),
                );
              },
            ),
            onTap: () => Modular.to.pushNamed('/chat/${item.id}'),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        key: const PageStorageKey('public-chats'),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }
}
