import 'package:askimam/chat/domain/model/chat.dart';
import 'package:askimam/chats/bloc/my_chats_bloc.dart';
import 'package:askimam/chats/ui/widget/public_chats_widget.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMyChatsBloc extends MockBloc<MyChatsEvent, MyChatsState>
    implements MyChatsBloc {}

void main() {
  late MyChatsBloc bloc;
  late Widget app;

  setUpAll(() {
    registerFallbackValue(const MyChatsState([]));
    registerFallbackValue(const MyChatsEvent.reload());
  });

  setUp(() {
    bloc = MockMyChatsBloc();

    app = MaterialApp(
      home: BlocProvider(
        create: (BuildContext context) => bloc,
        child: const Material(child: PublicChatsWidget()),
      ),
    );
  });

  testWidgets('should show a list', (tester) async {
    whenListen(
      bloc,
      Stream.value(const MyChatsState([])),
      initialState: MyChatsState([
        Chat(1, 'Chat 1'),
        Chat(2, 'Chat 2'),
      ]),
    );

    await tester.pumpWidget(app);

    expect(find.text('Chat 1'), findsOneWidget);
    expect(find.text('Chat 2'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
