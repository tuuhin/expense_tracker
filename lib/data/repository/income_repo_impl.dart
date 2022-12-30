import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../dto/dto.dart';
import '../entity/entity.dart';
import '../local/storage.dart';
import '../remote/remote.dart';
import '../../utils/resource.dart';
import '../../domain/models/models.dart';
import '../../domain/repositories/repositories.dart';

class IncomesRepoImpl implements IncomeRepostiory {
  final IncomeApi api;
  final IncomeStorage incomeStore;
  final IncomeSourceStorage sourceStore;

  IncomesRepoImpl({
    required this.api,
    required this.incomeStore,
    required this.sourceStore,
  });

  @override
  Future<List<IncomeSourceModel>> cachedSources() async =>
      (await sourceStore.getSources())
          .map((e) => IncomeSourceDto.fromEntity(e).toModel())
          .toList();

  @override
  Future<Resource<IncomeModel?>> createIncome(CreateIncomeModel income) async {
    try {
      IncomeDto dto = await api.createIncome(CreateIncomeDto.fromModel(income));
      await incomeStore.addIncome(dto.toEntity());
      IncomeEntity? entity = await incomeStore.getEntityById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);
      return Resource.data(data: IncomeDto.fromEntity(entity).toModel());
    } on DioError catch (err) {
      return Resource.error(err: err, errorMessage: "dio error");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "unknown error");
    }
  }

  @override
  Future<Resource<IncomeSourceModel?>> createSource(
      CreateIncomeSourceModel source) async {
    try {
      IncomeSourceDto dto =
          await api.createSource(CreateSourceDto.fromModel(source));
      await sourceStore.addSource(dto.toEntity());
      IncomeSourceEntity? entity =
          await sourceStore.getEntityById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);
      return Resource.data(data: IncomeSourceDto.fromEntity(entity).toModel());
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<void>> deleteSource(IncomeSourceModel source) async {
    try {
      await api.deleteSource(IncomeSourceDto.fromModel(source));
      await sourceStore
          .deleteSource(IncomeSourceDto.fromModel(source).toEntity());

      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<void>> deleteIncome(IncomeModel income) async {
    try {
      await api.deleteIncome(IncomeDto.fromModel(income));
      await incomeStore.deleteIncome(IncomeDto.fromModel(income).toEntity());

      return Resource.data(data: null);
    } catch (e) {
      return Resource.error(err: e, errorMessage: "Unknown error");
    }
  }

  @override
  Future<Resource<List<IncomeModel>>> getIncomes() async {
    try {
      Iterable<IncomeDto> incomes = await api.getIcomes();
      await incomeStore.deleteAll();
      await incomeStore.addIncomes(incomes.map((e) => e.toEntity()).toList());
      return Resource.data(
        data: (await incomeStore.getIncomes())
            .map((e) => IncomeDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e) {
      return Resource.error(
        err: e,
        errorMessage: "Unknown error",
        data: (await incomeStore.getIncomes())
            .map((e) => IncomeDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<Resource<List<IncomeSourceModel>>> getSources() async {
    try {
      Iterable<IncomeSourceDto> sources = await api.getSources();
      await sourceStore.deleteAll();
      await sourceStore.addSources(sources.map((e) => e.toEntity()).toList());
      return Resource.data(
        data: (await sourceStore.getSources())
            .map((e) => IncomeSourceDto.fromEntity(e).toModel())
            .toList(),
      );
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(
        err: e,
        errorMessage: "Unknown error",
        data: (await sourceStore.getSources())
            .map((e) => IncomeSourceDto.fromEntity(e).toModel())
            .toList(),
      );
    }
  }

  @override
  Future<Resource<IncomeModel?>> updateIncome(UpdateIncomeModel income) async {
    try {
      IncomeDto dto = await api.updateIncome(UpdateIncomeDto.fromModel(income));
      await incomeStore.updateIncome(dto.toEntity());
      IncomeEntity? entity = await incomeStore.getEntityById(dto.toEntity());
      if (entity == null) return Resource.data(data: null);
      return Resource.data(data: IncomeDto.fromEntity(entity).toModel());
    } on DioError catch (err) {
      return Resource.error(err: err, errorMessage: "dio error");
    } catch (e, stk) {
      debugPrintStack(stackTrace: stk);
      return Resource.error(err: e, errorMessage: "unknown error");
    }
  }

  @override
  Future<void> clearcachedIncomes() async => await incomeStore.deleteAll();

  @override
  Future<void> clearcachedSources() async => await sourceStore.deleteAll();
}
