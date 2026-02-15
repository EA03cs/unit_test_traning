import 'package:flutter_bloc/flutter_bloc.dart';
import 'notification_service.dart';

abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class NotificationLoading extends NotificationState {}
class NotificationLoaded extends NotificationState {
  final List<String> notifications;
  NotificationLoaded(this.notifications);
}
class NotificationError extends NotificationState {
  final String message;
  NotificationError(this.message);
}

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationService notificationService;

  NotificationCubit(this.notificationService) : super(NotificationInitial());

  Future<void> getNotifications() async {
    emit(NotificationLoading());
    try {
      final notifications = await notificationService.fetchNotifications();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
