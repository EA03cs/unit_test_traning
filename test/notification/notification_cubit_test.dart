import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:unit_test_traning/notification/notification_cubit.dart';
import 'package:unit_test_traning/notification/notification_service.dart';

class MockNotificationService extends Mock implements NotificationService {}

void main() {
  late NotificationCubit cubit;
  late MockNotificationService mockService;

  setUp(() {
    mockService = MockNotificationService();
    cubit = NotificationCubit(mockService);
  });

  tearDown(() {
    cubit.close();
  });

  group('NotificationCubit', () {
    test('initial state is NotificationInitial', () {
      expect(cubit.state, isA<NotificationInitial>());
    });

    blocTest<NotificationCubit, NotificationState>(
      'emits [NotificationLoading, NotificationLoaded] when fetch is successful',
      build: () {
        when(() => mockService.fetchNotifications())
            .thenAnswer((_) async => ['Title 1', 'Title 2']);
        return cubit;
      },
      act: (cubit) => cubit.getNotifications(),
      expect: () => [
        isA<NotificationLoading>(),
        isA<NotificationLoaded>(),
      ],
    );

    blocTest<NotificationCubit, NotificationState>(
      'emits [NotificationLoading, NotificationError] when fetch fails',
      build: () {
        when(() => mockService.fetchNotifications())
            .thenThrow(Exception('Network Error'));
        return cubit;
      },
      act: (cubit) => cubit.getNotifications(),
      expect: () => [
        isA<NotificationLoading>(),
        isA<NotificationError>(),
      ],
    );
  });
}
