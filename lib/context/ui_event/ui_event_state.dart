part of 'ui_event_cubit.dart';

@freezed
class UiEventState<T> with _$UiEventState<T> {
  const factory UiEventState.normal() = _Normal;

  const factory UiEventState.showSnackBar({required String message, T? data}) =
      _Snackbar;

  const factory UiEventState.showDialog(
      {required String message, required String content, T? data}) = _Dialog;
}
