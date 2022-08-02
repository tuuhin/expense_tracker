import 'package:dio/dio.dart';
import 'package:expense_tracker/data/dto/budget/budget_dto.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:expense_tracker/domain/repositories/budget_repository.dart';

class BudgetApi extends PlansClient implements BudgetRepository {
  @override
  Future createBudget() {
    // TODO: implement createBudget
    throw UnimplementedError();
  }

  @override
  Future deleteBudget() {
    // TODO: implement deleteBudget
    throw UnimplementedError();
  }

  @override
  Future<List<BudgetModel>> getBudget() async {
    Response response = await dio.get('/budget/');
    List models = response.data as List;
    return models.map((e) => BudgetDto.fromJson(e).toBudgetModel()).toList();
  }
}
