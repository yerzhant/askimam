import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/extention/date_extentions.dart';
import 'package:askimam/common/ui/theme.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart'
    hide ModularWatchExtension;

class SearchChatsWidget extends StatefulWidget {
  const SearchChatsWidget({super.key});

  @override
  State createState() => _SearchChatsWidgetState();
}

class _SearchChatsWidgetState extends State<SearchChatsWidget> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _searchBar(_controller),
        const Divider(height: 1),
        Expanded(
          child: BlocBuilder<SearchChatsBloc, SearchChatsState>(
            builder: (context, state) {
              return switch (state) {
                SearchChatsStateSuccess(chats: final items) =>
                  _list(items, context),
                SearchChatsStateInProgress() =>
                  InProgressWidget(child: Container()),
                SearchChatsStateError(rejection: final rejection) =>
                  RejectionWidget(
                    rejection: rejection,
                    onRefresh: () => context
                        .read<SearchChatsBloc>()
                        .add(SearchChatsEventFind(_controller.text)),
                  ),
              };
            },
          ),
        ),
      ],
    );
  }

  Row _searchBar(TextEditingController controller) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(left: basePadding),
            ),
            onSubmitted: (_) {
              _search(controller);
            },
          ),
        ),
        IconButton(
          onPressed: () {
            _search(controller);
          },
          icon: const Icon(Icons.search_rounded, color: primaryColor),
        ),
      ],
    );
  }

  void _search(TextEditingController controller) {
    if (controller.text.isNotEmpty) {
      context
          .read<SearchChatsBloc>()
          .add(SearchChatsEventFind(controller.text));
    }
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return ListView.separated(
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
          onTap: () => Modular.to.pushNamed('/chat/${item.id}'),
          minVerticalPadding: listTileMinVertPadding,
          subtitle: Padding(
            padding: const EdgeInsets.only(top: dateTopPadding),
            child: Text(
              item.updatedAt.format(),
              style: Theme.of(context).textTheme.caption,
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      key: const PageStorageKey('found-chats'),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
