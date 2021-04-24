import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/home/chats/bloc/public_chats_bloc.dart';
import 'package:askimam/common/ui/widget/in_progress_widget.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicChatsWidget extends StatelessWidget {
  const PublicChatsWidget();

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
        itemCount: items.length,
        itemBuilder: (_, i) => ListTile(title: Text(items[i].subject)),
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
