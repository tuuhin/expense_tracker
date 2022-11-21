part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.loading() = _Loading;
  const factory NotificationState.data(List<NotificationDataModel> data) =
      _Data;
  const factory NotificationState.error(String err) = _Error;
  const factory NotificationState.loadmore(List<NotificationDataModel> data) =
      _LoadMore;
  const factory NotificationState.errorLoadMore(
      List<NotificationDataModel> data, String message) = _ErrorLoadMore;
  const factory NotificationState.end(
      List<NotificationDataModel> data, String message) = _End;
}
