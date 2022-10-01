import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';

class BudgetDto {
  final int id;
  final String title;
  final String? desc;
  final DateTime statedFrom;
  final DateTime tillDate;
  final double amount;
  final double amountUsed;
  final DateTime issedAt;
  final bool hasExpired;

  BudgetDto({
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

  factory BudgetDto.fromJson(Map<String, dynamic> json) => BudgetDto(
        id: json['id'],
        title: json['title'],
        desc: json['desc'],
        statedFrom: DateTime.parse(json['_from']),
        tillDate: DateTime.parse(json['to']),
        amount: json['total_amount'],
        amountUsed: json['amount_used'],
        issedAt: DateTime.parse(json['issued_at']),
        hasExpired: json['has_expired'],
      );

  factory BudgetDto.fromModel(BudgetModel budgetModel) => BudgetDto(
      id: budgetModel.id,
      title: budgetModel.title,
      desc: budgetModel.desc,
      statedFrom: budgetModel.statedFrom,
      tillDate: budgetModel.tillDate,
      amount: budgetModel.amount,
      amountUsed: budgetModel.amountUsed,
      issedAt: budgetModel.issedAt,
      hasExpired: budgetModel.hasExpired);

  factory BudgetDto.fromEntity(BudgetEntity budgetEntity) => BudgetDto(
        id: budgetEntity.id,
        title: budgetEntity.title,
        desc: budgetEntity.desc,
        statedFrom: budgetEntity.statedFrom,
        tillDate: budgetEntity.tillDate,
        amount: budgetEntity.amount,
        amountUsed: budgetEntity.amountUsed,
        issedAt: budgetEntity.issedAt,
        hasExpired: budgetEntity.hasExpired,
      );

  BudgetModel toModel() => BudgetModel(
        id: id,
        title: title,
        desc: desc,
        statedFrom: statedFrom,
        tillDate: tillDate,
        amount: amount,
        amountUsed: amountUsed,
        issedAt: issedAt,
        hasExpired: hasExpired,
      );

  BudgetEntity toEntity() => BudgetEntity(
        id: id,
        title: title,
        desc: desc,
        statedFrom: statedFrom,
        tillDate: tillDate,
        amount: amount,
        amountUsed: amountUsed,
        issedAt: issedAt,
        hasExpired: hasExpired,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        '_from': statedFrom.toIso8601String(),
        'to': tillDate.toIso8601String(),
        'total_amount': amount,
        'amount_used': amountUsed,
        'issued_at': issedAt.toIso8601String(),
        'has_expired': hasExpired
      };
}
