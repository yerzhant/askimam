import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/home/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/home/chats/ui/new_question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'new_question_page_test.mocks.dart';

@GenerateMocks([MyChatsBloc])
void main() {
  late MyChatsBloc bloc;

  setUp(() {
    bloc = MockMyChatsBloc();
    when(bloc.state).thenReturn(const MyChatsState([]));
    when(bloc.stream).thenAnswer((_) => const Stream.empty());
  });

  testWidgets('should have elements', (tester) async {
    await _fixture(tester, bloc);

    expect(find.text('Публичный'), findsOneWidget);
    expect(find.text('Приватный'), findsOneWidget);
    expect(find.text('Введите тему'), findsOneWidget);
    expect(find.text('Введите вопрос'), findsOneWidget);
    expect(find.text('ОТПРАВИТЬ'), findsOneWidget);
  });

  testWidgets('should send a new question', (tester) async {
    await _fixture(tester, bloc);
    await tester.tap(find.text('Публичный'));
    await tester.enterText(find.byType(TextField).first, ' subject ');
    await tester.enterText(find.byType(TextField).last, ' text ');
    await tester.tap(find.text('ОТПРАВИТЬ'));

    verify(bloc.add(const MyChatsEvent.add(ChatType.Public, 'subject', 'text')))
        .called(1);

    // TODO: add route to my chats with popping itself
  });

  testWidgets('should send a new question without a subject', (tester) async {
    await _fixture(tester, bloc);
    await tester.tap(find.text('Публичный'));
    await tester.enterText(find.byType(TextField).last, 'text');
    await tester.tap(find.text('ОТПРАВИТЬ'));

    verify(bloc.add(const MyChatsEvent.add(ChatType.Public, null, 'text')))
        .called(1);
  });

  testWidgets('should not send a question without text', (tester) async {
    await _fixture(tester, bloc);
    await tester.tap(find.text('ОТПРАВИТЬ'));
    await tester.pump();

    expect(find.text('Введите значение'), findsOneWidget);
    verifyNever(bloc.add(const MyChatsEvent.add(ChatType.Private, null, '')));
  });
}

Future _fixture(WidgetTester tester, MyChatsBloc bloc) async {
  final app = MaterialApp(home: NewQuestionPage(bloc));
  await tester.pumpWidget(app);
}
