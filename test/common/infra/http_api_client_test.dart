import 'package:askimam/auth/bloc/auth_bloc.dart';
import 'package:askimam/auth/domain/model/authentication.dart';
import 'package:askimam/common/domain/model/rejection.dart';
import 'package:askimam/common/domain/service/api_client.dart';
import 'package:askimam/common/infra/dto/api_response.dart';
import 'package:askimam/common/infra/http_api_client.dart';
import 'package:askimam/favorites/domain/model/favorite.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mocktail/mocktail.dart' as mocktail;

part 'http_api_client_test.client.dart';

const apiUrl = 'https://server';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late ApiClient apiClient;
  late AuthBloc authBloc;

  setUpAll(() {
    mocktail.registerFallbackValue<AuthState>(AuthState.unauthenticated());
    mocktail.registerFallbackValue<AuthEvent>(AuthEvent.load());
  });

  setUp(() {
    authBloc = MockAuthBloc();
    whenListen(
      authBloc,
      Stream.value(
        AuthState.authenticated(Authentication('123', UserType.Inquirer)),
      ),
    );
    apiClient = HttpApiClient(httpClient, authBloc, apiUrl);
  });

  group('Get list:', () {
    test('should return a list', () async {
      whenListen(authBloc, Stream.value(AuthState.unauthenticated()));

      final result = await apiClient.getList<Favorite>('list');

      expect(
        result.getOrElse(() => []),
        [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ],
      );
    });

    test('should return an auth list', () async {
      final result = await apiClient.getList<Favorite>('auth-list');

      expect(
        result.getOrElse(() => []),
        [
          Favorite(1, 1, 'Тема'),
          Favorite(2, 2, 'Тема'),
        ],
      );
    });

    test('should return a rejection', () async {
      final result = await apiClient.getList<Favorite>('list-rejection');

      expect(result, left(Rejection('Что-то пошло не так')));
    });

    test('should return a nok', () async {
      final result = await apiClient.getList<Favorite>('list-nok');

      expect(result, left(Rejection('Response: 500, boom!')));
    });

    test('should return an exception', () async {
      final result = await apiClient.getList<Favorite>('list-x');

      expect(result, left(Rejection('Exception: x')));
    });
  });

  group('Delete:', () {
    test('should return none', () async {
      final result = await apiClient.delete('suffix/1');

      expect(result, none());
    });

    test('should return some rejection reason', () async {
      final result = await apiClient.delete('suffix/2');

      expect(result, some(Rejection('Что-то пошло не так')));
    });

    test('should return some nok', () async {
      final result = await apiClient.delete('suffix/3');

      expect(result, some(Rejection('Response: 500, boom!')));
    });

    test('should return some exception', () async {
      final result = await apiClient.delete('suffix/4');

      expect(result, some(Rejection('Exception: x')));
    });
  });
}

bool _isAuthorized(Request req) => req.headers['Authorization'] == 'Bearer 123';
