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
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class PublicChatsWidget extends StatefulWidget {
  const PublicChatsWidget({super.key});

  @override
  State createState() => _PublicChatsWidgetState();
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
      context.read<PublicChatsBloc>().add(const PublicChatsEventLoadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PublicChatsBloc, PublicChatsState>(
      builder: (context, state) {
        return switch (state) {
          PublicChatsStateSuccess(chats: final items) => _list(items, context),
          PublicChatsStateInProgress(chats: final items) =>
            InProgressWidget(child: _list(items, context)),
          PublicChatsStateError(rejection: final rejection) => RejectionWidget(
              rejection: rejection,
              onRefresh: () => context
                  .read<PublicChatsBloc>()
                  .add(const PublicChatsEventReload()),
            ),
        };
      },
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async =>
          context.read<PublicChatsBloc>().add(const PublicChatsEventReload()),
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
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            trailing: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return switch (state) {
                  AuthStateAuthenticated() => IconButton(
                      icon: Icon(
                        item.isFavorite
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: primaryColor,
                        size: iconSize,
                      ),
                      onPressed: () => context.read<FavoriteBloc>().add(
                            item.isFavorite
                                ? FavoriteEventDelete(item.id)
                                : FavoriteEventAdd(item),
                          ),
                    ),
                  _ => Container(width: 0),
                };
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
