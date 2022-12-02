part of 'goals_bloc.dart';

@freezed
class GoalsState with _$GoalsState {
  factory GoalsState.loading() = _Loading;

  factory GoalsState.success(
      {required List<GoalsModel> data, String? message}) = _Success;

  factory GoalsState.error({required String message, List<GoalsModel>? data}) =
      _Error;

  factory GoalsState.blank() = _Blank;
}
