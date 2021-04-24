import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chats/bloc/unanswered_chats_bloc.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnansweredChatsWidget extends StatelessWidget {
  const UnansweredChatsWidget();

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
        itemCount: items.length,
        itemBuilder: (_, i) {
          final item = items[i];

          return Dismissible(
            key: Key('$item'),
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
