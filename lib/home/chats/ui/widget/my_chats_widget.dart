import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class MyChatsWidget extends StatefulWidget {
  final AuthBloc authBloc;

  const MyChatsWidget(this.authBloc, {super.key});

  @override
  State createState() => _MyChatsWidgetState();
}

class _MyChatsWidgetState extends State<MyChatsWidget> {
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
      context.read<MyChatsBloc>().add(const MyChatsEventLoadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyChatsBloc, MyChatsState>(
      builder: (context, state) {
        return switch (state) {
          MyChatsStateSuccess(chats: final items) => _list(items, context),
          MyChatsStateInProgress(chats: final items) =>
            InProgressWidget(child: _list(items, context)),
          MyChatsStateError(rejection: final rejection) => RejectionWidget(
              rejection: rejection,
              onRefresh: () =>
                  context.read<MyChatsBloc>().add(const MyChatsEventReload()),
            ),
        };
      },
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<MyChatsBloc>().add(const MyChatsEventReload()),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) =>
                context.read<MyChatsBloc>().add(MyChatsEventDelete(item)),
            background: Container(color: secondaryColor),
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
              subtitle: _getSubtitle(item, widget.authBloc),
              leading: Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 4),
                    child: Icon(
                      item.type == ChatType.Public
                          ? Icons.public_rounded
                          : Icons.lock_rounded,
                      color: item.type == ChatType.Public
                          ? primaryColor
                          : secondaryDarkColor,
                      size: iconSize,
                    ),
                  ),
                  _getTrailingStatusIcon(item, widget.authBloc),
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  item.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                  color: primaryColor,
                  size: iconSize,
                ),
                onPressed: () => context.read<FavoriteBloc>().add(
                      item.isFavorite
                          ? FavoriteEventDelete(item.id)
                          : FavoriteEventAdd(item),
                    ),
              ),
              onTap: () => Modular.to.pushNamed('/chat/${item.id}'),
            ),
          );
        },
        key: const PageStorageKey('my-chats'),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }

  Widget _getSubtitle(Chat item, AuthBloc authBloc) {
    return switch (authBloc.state) {
      AuthStateAuthenticated(authentication: final auth) => () {
          if (auth.userType == UserType.Inquirer && !item.isViewedByInquirer ||
              auth.userType == UserType.Imam && !item.isViewedByImam) {
            return const Text('Есть новое сообщение',
                style: TextStyle(color: secondaryDarkColor));
          }
          return Padding(
            padding: const EdgeInsets.only(top: dateTopPadding),
            child: Text(
              item.updatedAt.format(),
              style: Theme.of(context).textTheme.caption,
            ),
          );
        }.call(),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _getTrailingStatusIcon(Chat item, AuthBloc authBloc) {
    return switch (authBloc.state) {
      AuthStateAuthenticated(authentication: final auth) => () {
          if (auth.userType == UserType.Inquirer && item.isViewedByImam ||
              auth.userType == UserType.Imam && item.isViewedByInquirer) {
            return Icon(
              Icons.check_rounded,
              size: 11,
              color: item.type == ChatType.Public
                  ? primaryColor
                  : secondaryDarkColor,
            );
          }

          return const SizedBox();
        }.call(),
      _ => const SizedBox(),
    };
  }
}
