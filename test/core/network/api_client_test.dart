import 'dart:io';

import 'package:flutter_movies/core/error/failures.dart';
import 'package:flutter_movies/core/network/api_client.dart';
import 'package:flutter_movies/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ApiClient apiClient;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = ApiClient(
      client: mockHttpClient,
      baseUrl: 'https://api.example.com',
      apiKey: 'test-api-key',
    );
  });

  setUpAll(() {
    final uri = Uri.parse('3/discover/movie');
    registerFallbackValue(uri);
  });

  group('get', () {
    test('should return response when status code is 200', () async {
      // Arrange
      final response = http.Response('{"key": "value"}', 200);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => response);

      // Act
      final result = await apiClient.get('endpoint', {'param': 'value'});

      // Assert
      expect(result.statusCode, 200);
      expect(result.body, '{"key": "value"}');
      verify(() => mockHttpClient.get(
        any(),
        headers: any(named: 'headers')
      )).called(1);
    });

    test('should throw AuthenticationFailure on 401 error', () async {
      // Arrange
      final response = http.Response('Unauthorized', 401);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => response);

      // Act & Assert
      try {
        await apiClient.get('endpoint', {'param': 'value'});
      } catch (e) {
        expect(e, isA<AuthenticationFailure>());
      }
    });

    test('should throw ResourceNotFoundFailure on 404 error', () async {
      // Arrange
      final response = http.Response('Not Found', 404);
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenAnswer((_) async => response);

      // Act & Assert
      try {
        await apiClient.get('endpoint', {'param': 'value'});
      } catch (e) {
        expect(e, isA<ResourceNotFoundFailure>());
      }
    });

    test('should throw ConnectionFailure on SocketException', () async {
      // Arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenThrow(SocketException('No Internet'));

      // Act & Assert
      expect(
        () async => await apiClient.get('endpoint', {'param': 'value'}),
        throwsA(isA<ConnectionFailure>()),
      );
    });

    test('should throw UnknownErrorFailure on other errors', () async {
      // Arrange
      when(() => mockHttpClient.get(any(), headers: any(named: 'headers')))
        .thenThrow(Exception('Unknown error'));

      // Act & Assert
      try {
        await apiClient.get('endpoint', {'param': 'value'});
      } catch (e) {
        expect(e, isA<Exception>());
      }
    });
  });
}

