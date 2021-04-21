import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/ui/ui_constants.dart';
import 'package:flutter/material.dart';

class RejectionWidget extends StatelessWidget {
  final Rejection rejection;
  final VoidCallback onRefresh;

  const RejectionWidget({
    Key? key,
    required this.rejection,
    required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Ошибка:'),
        const SizedBox(height: interElementPadding),
        Text(rejection.reason),
        const SizedBox(height: interElementPadding),
        ElevatedButton.icon(
          onPressed: onRefresh,
          icon: const Icon(Icons.refresh),
          label: const Text('ОБНОВИТЬ'),
        ),
      ],
    );
  }
}
