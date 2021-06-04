import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/search/bloc/search_chats_bloc.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchChatsWidget extends StatefulWidget {
  const SearchChatsWidget();

  @override
  _SearchChatsWidgetState createState() => _SearchChatsWidgetState();
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
        Expanded(
          child: BlocBuilder<SearchChatsBloc, SearchChatsState>(
            builder: (context, state) {
              return state.when(
                (items) => _list(items, context),
                inProgress: () => InProgressWidget(child: Container()),
                error: (rejection) => RejectionWidget(
                  rejection: rejection,
                  onRefresh: () => context
                      .read<SearchChatsBloc>()
                      .add(SearchChatsEvent.find(_controller.text)),
                ),
              );
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
          ),
        ),
        IconButton(
          onPressed: () {
            if (controller.text.isNotEmpty) {
              context
                  .read<SearchChatsBloc>()
                  .add(SearchChatsEvent.find(controller.text));
            }
          },
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (_, i) {
        final item = items[i];

        return ListTile(
          title: AutoDirection(text: item.subject, child: Text(item.subject)),
          onTap: () => Modular.to.pushNamed('/chat/${item.id}'),
        );
      },
      key: const PageStorageKey('found-chats'),
      padding: const EdgeInsets.symmetric(vertical: basePadding),
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
