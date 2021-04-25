import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/home/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: ListView.builder(
        controller: _scrollController,
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: ValueKey(item.id),
            onDismissed: (_) => context
                .read<UnansweredChatsBloc>()
                .add(UnansweredChatsEvent.delete(item)),
            child: ListTile(title: Text(item.subject)),
          );
        },
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
