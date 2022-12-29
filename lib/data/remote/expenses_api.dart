import 'package:dio/dio.dart';

import './remote.dart';
import '../dto/dto.dart';

class ExpensesApi extends ResourceClient {
  Future<ExpenseCategoryDto> createCategory(CreateCategoryDto dto) async {
    Response response = await dio.post('/categories', data: dto.toJson());
    return ExpenseCategoryDto.fromJson(response.data);
  }

  Future<ExpenseDto> createExpense(CreateExpenseDto dto) async {
    Response response = await dio.post(
      '/expenses',
      data: FormData.fromMap(
        {
          ...dto.toJson(),
          'receipt': dto.image != null
              ? await MultipartFile.fromFile(
                  dto.image!,
                  filename: dto.image,
                )
              : null
        },
      ),
    );
    return ExpenseDto.fromJson(response.data);
  }

  Future<ExpenseDto> updateExpense(UpdateExpenseDto dto) async {
    Response response = await dio.put(
      '/expenses/${dto.id}',
      data: FormData.fromMap(
        {
          ...dto.toJson(),
          'receipt': dto.image != null
              ? await MultipartFile.fromFile(
                  dto.image!,
                  filename: dto.image,
                )
              : null
        },
      ),
    );
    return ExpenseDto.fromJson(response.data);
  }

  Future<ExpenseCategoryDto> updateCategory(ExpenseCategoryDto dto) async {
    Response response =
        await dio.put('/categories/${dto.id}', data: dto.toJson());

    return ExpenseCategoryDto.fromJson(response.data);
  }

  Future deleteCategory(ExpenseCategoryDto category) async =>
      await dio.delete('/categories/${category.id}');

  Future deleteExpense(ExpenseDto expense) async =>
      await dio.delete('/expenses/${expense.id}');

  Future<Iterable<ExpenseCategoryDto>> getCategories() async {
    Response response = await dio.get('/categories');
    return (response.data as List)
        .map((json) => ExpenseCategoryDto.fromJson(json));
  }

  Future<Iterable<ExpenseDto>> getExpenses() async {
    Response response = await dio.get('/expenses');
    return (response.data as List).map((json) => ExpenseDto.fromJson(json));
  }
}
