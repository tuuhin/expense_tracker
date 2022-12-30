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

  factory UserBaseOverViewModel.noData() => const UserBaseOverViewModel(
      totalIncome: 0, monthlyIncome: 0, totalExpense: 0, monthlyExpense: 0);

  Map<String, double> get toMap => {
        "Total Income": totalIncome,
        "Total Expense": totalExpense,
        "Monthly Income": monthlyIncome,
        "Monthly Expense": monthlyExpense
      };
}
