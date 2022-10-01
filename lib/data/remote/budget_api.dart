import 'package:dio/dio.dart';
import 'package:expense_tracker/data/dto/budget/budget_dto.dart';
import 'package:expense_tracker/data/remote/remote.dart';
import 'package:expense_tracker/domain/models/budget/budget_model.dart';
import 'package:expense_tracker/domain/repositories/budget_repository.dart';

class BudgetApi extends PlansClient implements BudgetRepository {
  @override
  Future<BudgetModel> createBudget(String title, double amount,
      {required DateTime from, required DateTime to, String? desc}) async {
    Response response = await dio.post('/budget', data: {
      'title': title,
      'desc': desc,
      '_from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'total_amount': amount
    });

    return BudgetDto.fromJson(response.data).toModel();
  }

  @override
  Future<List<BudgetModel>> getBudget() async {
    Response response = await dio.get('/budget');
    List models = response.data as List;
    return models.map((e) => BudgetDto.fromJson(e).toModel()).toList();
  }
}
