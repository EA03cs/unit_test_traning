import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_traning/notification/notification_service.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late NotificationService notificationService;
  late MockHttpClient mockHttpClient;

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  setUp(() {
    mockHttpClient = MockHttpClient();
    notificationService = NotificationService(httpClient: mockHttpClient);
  });

  group('NotificationService', () {
    test('returns a list of notification titles if the http call completes successfully', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('[{"title": "Test 1"}, {"title": "Test 2"}]', 200),
      );

      final result = await notificationService.fetchNotifications();

      expect(result, isA<List<String>>());
      expect(result.length, 2);
      expect(result[0], 'Test 1');
    });

    test('throws an exception if the http call completes with an error', () async {
      when(() => mockHttpClient.get(any())).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      expect(() => notificationService.fetchNotifications(), throwsException);
    });
  });
}
