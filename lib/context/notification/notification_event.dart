part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.fetchSome() = FetchSome;
  const factory NotificationEvent.fetchMore() = FetchMore;
}
