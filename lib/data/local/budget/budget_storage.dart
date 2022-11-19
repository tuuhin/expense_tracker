import 'package:expense_tracker/data/dto/budget/budget_dto.dart';
import 'package:expense_tracker/data/entity/entity.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:hive/hive.dart';

class BudgetStorage {
  static Box<BudgetEntity>? budget;

  static Future<void> init() async {
    budget = await Hive.openBox<BudgetEntity>('budget');
  }

  Future<void> addBudget(BudgetModel budgetModel) async => await budget!.add(
        BudgetDto.fromModel(budgetModel).toEntity(),
      );

  Future<void> addBudgets(List<BudgetModel> budgetModels) async =>
      await budget!.addAll(
        budgetModels.map(
          (BudgetModel model) => BudgetDto.fromModel(model).toEntity(),
        ),
      );

  static List<BudgetModel> getBudget() => budget!.values
      .map((BudgetEntity e) => BudgetDto.fromEntity(e).toModel())
      .toList();

  Future<void> deleteBudget(BudgetModel budgetModel) async {
    int index =
        getBudget().indexWhere((element) => element.id == budgetModel.id);
    await budget!.deleteAt(index);
  }

  Future<void> deleteAllBudget() async => await budget!.clear();
}
