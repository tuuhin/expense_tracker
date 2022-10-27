// ignore_for_file: unnecessary_this

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_base_overview_model.freezed.dart';

@freezed
class UserBaseOverViewModel with _$UserBaseOverViewModel {
  const UserBaseOverViewModel._();
  const factory UserBaseOverViewModel({
    required double totalIncome,
    required double monthlyIncome,
    required double totalExpense,
    required double monthlyExpense,
  }) = _UserBaseOverViewModel;

  List get toList => [totalIncome, totalExpense, monthlyIncome, monthlyExpense];
}
