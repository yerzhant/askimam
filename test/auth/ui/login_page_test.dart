import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/auth/ui/login_page.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_page_test.mocks.dart';

@GenerateMocks([AuthBloc, IModularNavigator])
void main() {
  late AuthBloc bloc;
  late IModularNavigator navigator;

  setUp(() {
    provideDummy<AuthState>(const AuthStateInProgress());

    bloc = MockAuthBloc();
    when(bloc.stream).thenAnswer((_) => const Stream.empty());
    when(bloc.state).thenReturn(const AuthStateUnauthenticated());

    navigator = MockIModularNavigator();
    Modular.navigatorDelegate = navigator;
  });

  testWidgets('should contain elements', (tester) async {
    await _fixture(tester, bloc);

    expect(find.text('Логин'), findsOneWidget);
    expect(find.text('Пароль'), findsOneWidget);
    expect(find.text('Регистрация'), findsOneWidget);
    expect(find.text('Забыли пароль?'), findsOneWidget);
    expect(find.text('ВОЙТИ'), findsOneWidget);
  });

  testWidgets('should not allow to leave empty fields', (tester) async {
    await _fixture(tester, bloc);
    await tester.tap(find.text('ВОЙТИ'));
    await tester.pump();

    expect(find.text('Введите логин'), findsOneWidget);
    expect(find.text('Введите пароль'), findsOneWidget);
  });

  testWidgets('should send auth command/event', (tester) async {
    await _fixture(tester, bloc);
    await tester.enterText(find.byType(TextFormField).first, 'login');
    await tester.enterText(find.byType(TextFormField).last, 'password');
    await tester.tap(find.text('ВОЙТИ'));
    await tester.pump();

    verify(
      bloc.add(const AuthEventLogin('login', 'password')),
    ).called(1);
  });

  testWidgets('should by in progress', (tester) async {
    when(bloc.state).thenReturn(const AuthStateInProgress());
    await _fixture(tester, bloc);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show an error', (tester) async {
    when(bloc.stream)
        .thenAnswer((_) => Stream.value(AuthStateError(Rejection('reason'))));
    await _fixture(tester, bloc);
    await tester.pump();

    expect(find.text('reason'), findsOneWidget);
  });

  testWidgets('should go to home page', (tester) async {
    when(bloc.stream).thenAnswer((_) => Stream.value(
        const AuthStateAuthenticated(
            Authentication('123', 1, UserType.Inquirer))));
    await _fixture(tester, bloc);
    await tester.pump();

    verify(navigator.pop()).called(1);
  });
}

Future _fixture(WidgetTester tester, AuthBloc bloc) async {
  final widget = MaterialApp(home: LoginPage(bloc));
  await tester.pumpWidget(widget);
}
