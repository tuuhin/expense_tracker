import 'package:dio/dio.dart';
import 'package:expense_tracker/data/dto/dto.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/models.dart';
import 'package:expense_tracker/domain/repositories/income_repository.dart';

class IncomeApi extends ResourceClient implements IncomeRepostiory {
  @override
  Future<IncomeModel?> createIncome(String title, double amount,
      {String? desc, List<IncomeSourceModel>? sources}) async {
    Response response = await dio.post(
      '/income',
      data: {
        'title': title,
        'desc': desc,
        'source': sources
                ?.map((e) => IncomeSourceDto.fromIncomeSourceModel(e).toJson())
                .toList() ??
            [],
        'amount': amount
      },
    );
    return IncomeDto.fromJson(response.data).toIncomeModel();
  }

  @override
  Future<IncomeSourceModel?> createSource(String title,
      {String? desc, bool? isSecure}) async {
    Response response = await dio.post('/sources',
        data: {'title': title, 'desc': desc, 'isSecure': isSecure});
    return IncomeSourceDto.fromJson(response.data).toIncomeSourceModel();
  }

  @override
  Future<List<IncomeModel>?> getIcomes() async {
    Response response = await dio.get('/income');
    List incomes = response.data as List;
    return incomes
        .map((json) => IncomeDto.fromJson(json).toIncomeModel())
        .toList();
  }

  @override
  Future<List<IncomeSourceModel>?> getSources() async {
    Response response = await dio.get('/sources');
    List sources = response.data as List;
    return sources
        .map((json) => IncomeSourceDto.fromJson(json).toIncomeSourceModel())
        .toList();
  }

  @override
  Future deleteIncome(IncomeModel incomeModel) async =>
      await dio.delete('/income/${incomeModel.id}');

  @override
  Future deleteSource(IncomeSourceModel incomeSourceModel) async =>
      await dio.delete('/sources/${incomeSourceModel.id}');
}
