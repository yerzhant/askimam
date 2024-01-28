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
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class UnansweredChatsWidget extends StatefulWidget {
  const UnansweredChatsWidget({super.key});

  @override
  State createState() => _UnansweredChatsWidgetState();
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
          .add(const UnansweredChatsEventLoadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UnansweredChatsBloc, UnansweredChatsState>(
      builder: (context, state) {
        return switch (state) {
          UnansweredChatsStateSuccess(chats: final items) =>
            _list(items, context),
          UnansweredChatsStateInProgress(chats: final items) =>
            InProgressWidget(child: _list(items, context)),
          UnansweredChatsStateError(rejection: final rejection) =>
            RejectionWidget(
              rejection: rejection,
              onRefresh: () => context
                  .read<UnansweredChatsBloc>()
                  .add(const UnansweredChatsEventReload()),
            ),
        };
      },
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: () async => context
          .read<UnansweredChatsBloc>()
          .add(const UnansweredChatsEventReload()),
      child: ListView.separated(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) => context
                .read<UnansweredChatsBloc>()
                .add(UnansweredChatsEventDelete(item)),
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
              subtitle: Padding(
                padding: const EdgeInsets.only(top: dateTopPadding),
                child: Text(
                  item.updatedAt.format(),
                  style: Theme.of(context).textTheme.bodySmall,
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
                      color: primaryColor,
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
      return const Icon(
        Icons.check_rounded,
        color: primaryColor,
        size: 11,
      );
    }

    return const SizedBox();
  }
}
