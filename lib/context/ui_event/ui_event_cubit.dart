import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ui_event_state.dart';
part 'ui_event_cubit.freezed.dart';

class UiEventCubit<T> extends Cubit<UiEventState<T>> {
  UiEventCubit() : super(const UiEventState.normal());

  void showSnackBar(String message, {T? data}) {
    emit(UiEventState.showSnackBar(message: message, data: data));
    emit(const UiEventState.normal());
  }

  void showDialog(String message, {String? secondary, T? data}) {
    emit(UiEventState.showDialog(
        message: message, content: secondary, data: data));
    emit(const UiEventState.normal());
  }
}
