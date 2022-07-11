import 'package:expense_tracker/domain/models/models.dart';

class IncomeModel {
  final String title;
  final double amount;
  final DateTime addedAt;
  final List<IncomeSourceModel?>? sources;
  final String? desc;
  IncomeModel({
    required this.title,
    required this.amount,
    required this.addedAt,
    this.sources,
    this.desc,
  });
}
