import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/domain/models/income/income_models.dart';

class IncomeDto {
  final int id;
  final String title;
  final double amount;
  final DateTime addedAt;
  final List<IncomeSourceDto>? sources;
  final String? desc;
  IncomeDto({
    required this.id,
    required this.title,
    required this.amount,
    required this.addedAt,
    this.sources,
    this.desc,
  });

  factory IncomeDto.fromJson(Map<String, dynamic> json) {
    List sources = json['sources'] as List;
    return IncomeDto(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      amount: json['amount'],
      addedAt: DateTime.parse(json['addedAt']),
      sources:
          sources.map((source) => IncomeSourceDto.fromJson(source)).toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'sources': sources!.map((e) => e.toJson()),
        'amount': amount
      };

  IncomeModel toIncomeSourceModel() => IncomeModel(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources!.map((e) => e.toIncomeSourceModel()).toList(),
      desc: desc);

  factory IncomeDto.fromIncomeSourceModel(IncomeModel incomeSourceModel) =>
      IncomeDto(
        id: incomeSourceModel.id,
        title: incomeSourceModel.title,
        desc: incomeSourceModel.desc,
        amount: incomeSourceModel.amount,
        addedAt: incomeSourceModel.addedAt,
        sources: incomeSourceModel.sources!
            .map((e) => IncomeSourceDto.fromIncomeSourceModel(e!))
            .toList(),
      );
}
