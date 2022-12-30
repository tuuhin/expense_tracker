import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../dto/dto.dart';
import '../entity/entity.dart';
import '../local/storage.dart';
import '../remote/budget_api.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class BudgetRepositoryImpl implements BudgetRepository {
  final BudgetApi api;
  final BudgetStorage cache;

  BudgetRepositoryImpl({required this.api, required this.cache});

  @override
  Future<Resource<BudgetModel?>> createBudget(CreateBudgetModel budget) async {
    try {
      BudgetDto dto = await api.createBudget(CreateBudgetDto.fromModel(budget));
      await cache.addBudget(dto.toEntity());
      BudgetEntity? entity = await cache.getBudgetById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);
      return Resource.data(
          data: BudgetDto.fromEntity(entity).toModel(),
          message: "Succesfully Created your budget");
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "Failed to error");
    }
  }

  @override
  Future<Resource<List<BudgetModel>>> getBudget() async {
    try {
      List<BudgetDto> dtos = await api.getBudget();
      await cache.deleteAll();
      await cache.addBudgets(dtos.map((e) => e.toEntity()).toList());
      return Resource.data(
        data: (await cache.getBudget())
            .map((e) => BudgetDto.fromEntity(e).toModel())
            .toList(),
      );
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
        data: (await cache.getBudget())
            .map((e) => BudgetDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(
        err: e,
        errorMessage: "Unknown Error Occured",
        data: (await cache.getBudget())
            .map((e) => BudgetDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<Resource<void>> deleteBudget(BudgetModel budget) async {
    try {
      await api.deleteBudget(BudgetDto.fromModel(budget));
      await cache.deleteBudget(BudgetDto.fromModel(budget).toEntity());
      return Resource.data(data: null);
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
      );
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Failed to delete budget");
    }
  }

  @override
  Future<Resource<BudgetModel?>> updateBudget(BudgetModel budget) async {
    try {
      BudgetDto dto = await api.updateBudget(BudgetDto.fromModel(budget));
      await cache.updateBudget(dto.toEntity());
      BudgetEntity? entity = await cache.getBudgetById(dto.toEntity());
      if (entity == null) return Resource.data(data: null, message: "Null");
      return Resource.data(
          data: BudgetDto.fromEntity(entity).toModel(),
          message: "Successfully updated budget ${budget.id}");
    } on DioError catch (dio) {
      return Resource.error(
        err: dio,
        errorMessage: dio.type == DioErrorType.response
            ? ErrorDetialsDto.fromJson(
                        (dio.response?.data as Map<String, dynamic>))
                    .details ??
                "Something related to dio occered "
            : "Some dio error happened",
      );
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error occured");
    }
  }

  @override
  Future<List<BudgetModel>> cachedBudget() async => (await cache.getBudget())
      .map((e) => BudgetDto.fromEntity(e).toModel())
      .toList();

  @override
  Future<void> clearCache() async => await cache.deleteAll();
}
