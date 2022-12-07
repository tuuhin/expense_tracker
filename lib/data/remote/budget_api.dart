import 'package:dio/dio.dart';

import '../dto/dto.dart';
import 'clients/plans_client.dart';

class BudgetApi extends PlansClient {
  Future<BudgetDto> createBudget(CreateBudgetDto dto) async {
    Response response = await dio.post('/budget', data: dto.toJson());
    return BudgetDto.fromJson(response.data);
  }

  Future<List<BudgetDto>> getBudget() async {
    Response response = await dio.get('/budget');
    return (response.data as List).map((e) => BudgetDto.fromJson(e)).toList();
  }

  Future<BudgetDto> updateBudget(BudgetDto dto) async {
    Response response = await dio.put('/budget/${dto.id}', data: dto.toJson());
    return BudgetDto.fromJson(response.data);
  }

  Future deleteBudget(BudgetDto budget) async =>
      await dio.delete('/budget/${budget.id}');
}
