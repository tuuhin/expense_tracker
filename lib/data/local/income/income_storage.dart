import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/data/entity/income/income_entity.dart';
import 'package:expense_tracker/domain/models/income/income_models.dart';
import 'package:hive/hive.dart';

class IncomeStorage {
  static Box<IncomeEntity>? income;

  static Future<void> init() async {
    income = await Hive.openBox<IncomeEntity>('income');
  }

  Future<void> addIncome(IncomeModel incomeModel) async => await income!.add(
        IncomeDto.fromIncomeModel(incomeModel).toEntity(),
      );

  Future<void> addIncomes(List<IncomeModel> incomeSourceModels) async =>
      await income!.addAll(
        incomeSourceModels.map(
          (IncomeModel model) => IncomeDto.fromIncomeModel(model).toEntity(),
        ),
      );

  List<IncomeModel> getIncomes() => income!.values
      .map((IncomeEntity e) => IncomeDto.fromEntity(e).toIncomeModel())
      .toList();

  Future<void> deleteIncomeModel(IncomeModel incomeModel) async {
    int index =
        getIncomes().indexWhere((element) => element.id == incomeModel.id);
    await income!.deleteAt(index);
  }

  Future<void> deleteIncomeModels() async => await income!.clear();
}
