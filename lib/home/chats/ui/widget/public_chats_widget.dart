import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:askimam/home/favorites/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: ListView.builder(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return ListTile(
            title: Text(item.subject),
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
          );
        },
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
