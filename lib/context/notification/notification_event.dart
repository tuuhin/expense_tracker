part of 'notification_bloc.dart';

@freezed
class NotificationEvent with _$NotificationEvent {
  factory NotificationEvent.fetchSome() = _FetchSome;
  factory NotificationEvent.fetchMore() = _FetchMore;
  factory NotificationEvent.refresh() = _Refresh;
  factory NotificationEvent.clear() = _Clear;
}
