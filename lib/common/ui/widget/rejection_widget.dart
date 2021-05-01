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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(basePadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ой, шо-то пошло не так!',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            const SizedBox(height: interElementMargin),
            Text(rejection.message),
            const SizedBox(height: interElementMargin),
            ElevatedButton.icon(
              onPressed: onRefresh,
              icon: const Icon(Icons.repeat),
              label: const Text('ПОВТОРИТЬ'),
            ),
          ],
        ),
      ),
    );
  }
}
