part of 'ui_event_cubit.dart';

@freezed
class UiEventState<T> with _$UiEventState<T> {
  factory UiEventState.normal() = _Normal;

  factory UiEventState.showSnackBar({required String message, T? data}) =
      _Snackbar;

  factory UiEventState.showDialog(
      {required String message, required String content, T? data}) = _Dialog;
}
