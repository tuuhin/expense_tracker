import 'package:hive/hive.dart';
import '../../../domain/models/income/income_source_model.dart';
import '../../dto/income/income_source_dto.dart';
import '../../entity/income/income_source_entity.dart';

class IncomeSourceStorage {
  static Box<IncomeSourceEntity>? incomeSource;

  static Future<void> init() async {
    incomeSource = await Hive.openBox<IncomeSourceEntity>('income_source');
  }

  Future<void> addIncomeSource(IncomeSourceModel incomeSourceModel) async =>
      await incomeSource!.add(
        IncomeSourceDto.fromIncomeSourceModel(incomeSourceModel).toEntity(),
      );

  Future<void> addIncomeSources(
          List<IncomeSourceModel> incomeSourceModels) async =>
      await incomeSource!.addAll(
        incomeSourceModels.map(
          (IncomeSourceModel model) =>
              IncomeSourceDto.fromIncomeSourceModel(model).toEntity(),
        ),
      );

  List<IncomeSourceModel> getIncomeSources() => incomeSource!.values
      .map((IncomeSourceEntity e) =>
          IncomeSourceDto.fromEntity(e).toIncomeSourceModel())
      .toList();

  Future<void> deleteIncomeSource(IncomeSourceModel incomeSourceModel) async {
    int index = getIncomeSources()
        .indexWhere((element) => element.id == incomeSourceModel.id);
    await incomeSource!.deleteAt(index);
  }

  Future<void> deleteIncomeSources() async => await incomeSource!.clear();
}
