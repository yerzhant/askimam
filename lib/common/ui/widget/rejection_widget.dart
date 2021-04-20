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
        Text('Ошибка:'),
        SizedBox(height: interElementPadding),
        Text(rejection.reason),
        SizedBox(height: interElementPadding),
        ElevatedButton.icon(
          onPressed: onRefresh,
          icon: Icon(Icons.refresh),
          label: Text('ОБНОВИТЬ'),
        ),
      ],
    );
  }
}
