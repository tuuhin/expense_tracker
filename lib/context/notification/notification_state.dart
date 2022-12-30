part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  factory NotificationState.loading() = _Loading;

  factory NotificationState.data({
    required List<NotificationDataModel> data,
  }) = _Data;

  factory NotificationState.noData({
    required String message,
  }) = _NoData;

  const factory NotificationState.error({
    required Object err,
    required String message,
  }) = _Error;

  factory NotificationState.loadmore({
    required List<NotificationDataModel> data,
  }) = _LoadMore;

  factory NotificationState.errorLoadMore({
    required Object err,
    required String message,
    required List<NotificationDataModel> data,
  }) = _ErrorLoadMore;

  factory NotificationState.end({
    required String message,
    required List<NotificationDataModel> data,
  }) = _End;
}
