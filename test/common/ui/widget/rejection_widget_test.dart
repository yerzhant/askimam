import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/ui/widget/rejection_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var isRefreshed = false;

  final app = MaterialApp(
    home: RejectionWidget(
      rejection: Rejection('reason'),
      onRefresh: () => isRefreshed = true,
    ),
  );

  testWidgets('should have texts', (tester) async {
    await tester.pumpWidget(app);

    expect(find.text('Ошибка:'), findsOneWidget);
    expect(find.text('reason'), findsOneWidget);
    expect(find.text('ОБНОВИТЬ'), findsOneWidget);
  });

  testWidgets('should be refreshed', (tester) async {
    await tester.pumpWidget(app);
    await tester.tap(find.text('ОБНОВИТЬ'));

    expect(isRefreshed, true);
  });
}
