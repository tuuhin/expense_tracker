part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  const factory NotificationEvent.fetchSome() = _FetchSome;
  const factory NotificationEvent.fetchMore() = _FetchMore;

  const factory NotificationEvent.refresh() = _Refresh;
}
