class BudgetModel {
  final int id;
  final String title;
  final String? desc;
  final DateTime statedFrom;
  final DateTime tillDate;
  final double amount;
  final double amountUsed;
  final DateTime issedAt;
  final bool hasExpired;

  BudgetModel({
    required this.id,
    required this.title,
    this.desc,
    required this.statedFrom,
    required this.tillDate,
    required this.amount,
    required this.amountUsed,
    required this.issedAt,
    required this.hasExpired,
  });
}
