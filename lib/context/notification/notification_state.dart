part of 'notification_bloc.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.loading() = _Loading;

  const factory NotificationState.data({
    required List<NotificationDataModel> data,
  }) = _Data;

  const factory NotificationState.noData({
    required String message,
  }) = _NoData;

  const factory NotificationState.error({
    required Object err,
    required String message,
  }) = _Error;

  const factory NotificationState.loadmore({
    required List<NotificationDataModel> data,
  }) = _LoadMore;

  const factory NotificationState.errorLoadMore({
    required Object err,
    required String message,
    required List<NotificationDataModel> data,
  }) = _ErrorLoadMore;

  const factory NotificationState.end({
    required String message,
    required List<NotificationDataModel> data,
  }) = _End;
}
