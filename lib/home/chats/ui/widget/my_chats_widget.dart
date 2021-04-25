import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MyChatsWidget extends StatefulWidget {
  const MyChatsWidget();

  @override
  _MyChatsWidgetState createState() => _MyChatsWidgetState();
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
      context.read<MyChatsBloc>().add(const MyChatsEvent.loadNextPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyChatsBloc, MyChatsState>(
      builder: (context, state) {
        return state.when(
          (items) => _list(items, context),
          inProgress: (items) => InProgressWidget(child: _list(items, context)),
          error: (rejection) => RejectionWidget(
            rejection: rejection,
            onRefresh: () =>
                context.read<MyChatsBloc>().add(const MyChatsEvent.reload()),
          ),
        );
      },
    );
  }

  Widget _list(List<Chat> items, BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<MyChatsBloc>().add(const MyChatsEvent.reload()),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) =>
                context.read<MyChatsBloc>().add(MyChatsEvent.delete(item)),
            child: ListTile(
              title: Text(item.subject),
              leading: Icon(
                item.type == ChatType.Public ? Icons.public : Icons.lock,
              ),
              trailing: IconButton(
                icon: Icon(
                  item.isFavorite ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: () => context.read<FavoriteBloc>().add(
                      item.isFavorite
                          ? FavoriteEvent.delete(item.id)
                          : FavoriteEvent.add(item),
                    ),
              ),
              onTap: () => Modular.to.navigate('/chat/${item.id}'),
            ),
          );
        },
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
