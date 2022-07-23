import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/domain/models/models.dart';

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
    List? sources = json['source'] as List?;

    return IncomeDto(
      id: json['id'],
      title: json['title'],
      desc: json['desc'],
      amount: json['amount'],
      addedAt: DateTime.parse(json['added_at']),
      sources:
          sources?.map((source) => IncomeSourceDto.fromJson(source)).toList(),
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'desc': desc,
        'sources': sources?.map((e) => e.toJson()),
        'amount': amount
      };

  IncomeModel toIncomeModel() => IncomeModel(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources!.map((e) => e.toIncomeSourceModel()).toList(),
      desc: desc);

  IncomeEntity toEntity() => IncomeEntity(
      id: id,
      title: title,
      amount: amount,
      addedAt: addedAt,
      sources: sources!.map((e) => e.toEntity()).toList(),
      desc: desc);

  factory IncomeDto.fromEntity(IncomeEntity incomeEntity) => IncomeDto(
        id: incomeEntity.id,
        title: incomeEntity.title,
        desc: incomeEntity.desc,
        amount: incomeEntity.amount,
        addedAt: incomeEntity.addedAt,
        sources: incomeEntity.sources!
            .map((e) => IncomeSourceDto.fromEntity(e))
            .toList(),
      );

  factory IncomeDto.fromIncomeModel(IncomeModel incomeModel) => IncomeDto(
        id: incomeModel.id,
        title: incomeModel.title,
        desc: incomeModel.desc,
        amount: incomeModel.amount,
        addedAt: incomeModel.addedAt,
        sources: incomeModel.sources!
            .map((e) => IncomeSourceDto.fromIncomeSourceModel(e!))
            .toList(),
      );
}
