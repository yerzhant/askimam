import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UnansweredChatsWidget extends StatefulWidget {
  const UnansweredChatsWidget();

  @override
  _UnansweredChatsWidgetState createState() => _UnansweredChatsWidgetState();
}

class _UnansweredChatsWidgetState extends State<UnansweredChatsWidget> {
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
          .read<UnansweredChatsBloc>()
          .add(const UnansweredChatsEvent.loadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnansweredChatsBloc, UnansweredChatsState>(
      builder: (context, state) {
        return state.when(
          (items) => _list(items, context),
          inProgress: (items) => InProgressWidget(child: _list(items, context)),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () => context
                .read<UnansweredChatsBloc>()
                .add(const UnansweredChatsEvent.reload()),
          ),
        );
      },
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context
          .read<UnansweredChatsBloc>()
          .add(const UnansweredChatsEvent.reload()),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) => context
                .read<UnansweredChatsBloc>()
                .add(UnansweredChatsEvent.delete(item)),
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
              subtitle: Padding(
                padding: const EdgeInsets.only(top: dateTopPadding),
                child: Text(
                  item.updatedAt.format(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
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
                  _getViewedIcon(item),
                ],
              ),
              onTap: () => Modular.to.pushNamed('/chat/${item.id}'),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        key: const PageStorageKey('unanswered-chats'),
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
      ),
    );
  }

  Widget _getViewedIcon(Chat item) {
    if (item.isViewedByImam) {
      return Icon(
        Icons.check_rounded,
        size: 11,
        color: item.type == ChatType.Public ? primaryColor : secondaryDarkColor,
      );
    }

    return const SizedBox();
  }
}
