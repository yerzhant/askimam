import 'package:askimam/home/chats/ui/new_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should have elements', (tester) async {
    await _fixture(tester);

    expect(find.text('Введите тему'), findsOneWidget);
    expect(find.text('Введите вопрос'), findsOneWidget);
    expect(find.text('Публичный'), findsOneWidget);
    expect(find.text('Приватный'), findsOneWidget);
    expect(find.text('ОТПРАВИТЬ'), findsOneWidget);
  });
}

Future _fixture(WidgetTester tester) async {
  final app = MaterialApp(home: NewQuestionPage());
  await tester.pumpWidget(app);
}
